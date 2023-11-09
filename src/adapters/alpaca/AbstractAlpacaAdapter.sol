// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";

import "../BaseAdapter.sol";
import "../../interfaces/alpaca/IMoneyMarket.sol";
import "../../interfaces/alpaca/IInterestBearingToken.sol";
import "../../interfaces/alpaca/IMoneyMarketAccountManager.sol";

abstract contract AbstractAlpacaAdapter is BaseAdapter {

    using SafeERC20 for IERC20;
    using SafeERC20 for IInterestBearingToken;

    IMoneyMarketAccountManager public immutable MANAGER;
    IInterestBearingToken public immutable IB_TOKEN;
    IERC20 public immutable BASE_TOKEN;

    constructor(
        address _balancer, 
        address _manager, 
        address _base
    ) BaseAdapter(_balancer) {
        MANAGER = IMoneyMarketAccountManager(_manager);

        IMoneyMarket _market = IMoneyMarket(MANAGER.moneyMarket());
        IB_TOKEN = IInterestBearingToken(_market.getIbTokenFromToken(_base));
        BASE_TOKEN = IERC20(_base);
    }

    receive() external payable {}

    function _invest() internal override {
        uint _balance = BASE_TOKEN.balanceOf(address(this));
        if (_balance > 0) {
            BASE_TOKEN.forceApprove(address(MANAGER), _balance);
            MANAGER.deposit(address(BASE_TOKEN), _balance);
        }
    } 
    
    function _redeem(uint256 lpAmount, address to)
        internal
        override
        returns (address[] memory tokens, uint[] memory amounts) 
    {
        IB_TOKEN.forceApprove(address(MANAGER), lpAmount);

        uint _balanceBefore = BASE_TOKEN.balanceOf(address(this));
        MANAGER.withdraw(address(IB_TOKEN), lpAmount);
        uint _balanceAfter = BASE_TOKEN.balanceOf(address(this));
        
        uint _received = _balanceAfter - _balanceBefore;
        IERC20(BASE_TOKEN).safeTransfer(to, _received);

        tokens = new address[](1);
        amounts = new uint[](1);

        tokens[0] = address(BASE_TOKEN);
        amounts[0] = _received;              
    }

    function _claimAll() internal override {
        revert("This adapter can\'t compound");
    }

    function negotiableTokens() public override returns(address[] memory tokens) {
        tokens = new address[](2);
        tokens[0] = address(BASE_TOKEN);
        tokens[1] = address(IB_TOKEN);
    }

    function depositTokens() public override view returns (address[] memory tokens) {
        tokens = new address[](1);
        tokens[0] = address(BASE_TOKEN);
    }

    function value() public view override returns (uint estimatedValue, uint lpAmount) {
        lpAmount = IB_TOKEN.balanceOf(address(this));
        estimatedValue = _baseValue(IB_TOKEN.convertToAssets(lpAmount));
    }

    function _baseValue(uint _baseAmount) internal view virtual returns (uint);

    function pendingRewards() external view override returns(address[] memory tokens, uint[] memory amounts) {
        tokens = new address[](0);
        amounts = new uint[](0);
    }

    function ratios() external view override returns(address[] memory tokens, uint[] memory ratio) {
        tokens = new address[](1);
        ratio  = new uint[](1);

        tokens[0] = address(BASE_TOKEN);
        ratio[0] = 1e18;
    }

    function description() external override returns (string memory) {
        return string.concat(
                '{"type":"alpaca","manager": "',
                Strings.toHexString(address(MANAGER)),
                '","baseToken: "',
                Strings.toHexString(address(BASE_TOKEN)),
                '","ibToken: "',
                Strings.toHexString(address(IB_TOKEN)),
                '"}'
            );
    }

}