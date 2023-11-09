// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/extensions/IERC20Metadata.sol";
import "openzeppelin/utils/Address.sol";
import "openzeppelin/utils/math/SafeCast.sol";
import "openzeppelin/utils/Strings.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";

import "./BaseAdapter.sol";
import "../interfaces/IAdapter.sol";
import "../interfaces/thena/IGaugeV2.sol";
import "../interfaces/IBalancer.sol";
import "../interfaces/thena/IPair.sol";

abstract contract ThenaPairAdapter is BaseAdapter {

    using SafeERC20 for IERC20;

    IPair       public immutable PAIR;
    IGaugeV2    public immutable GAUGE;
    IERC20      public immutable TOKEN0;
    IERC20      public immutable TOKEN1;
    IERC20      public immutable REWARD_TOKEN;

    string private DESCRIPTION;

    constructor(address _balancer, address _gauge, string memory _description) BaseAdapter(_balancer) {
        GAUGE = IGaugeV2(_gauge);
        PAIR = IPair(GAUGE.TOKEN());

        (address token0, address token1) = PAIR.tokens();
        TOKEN0 = IERC20(token0);
        TOKEN1 = IERC20(token1);
        REWARD_TOKEN = IERC20(GAUGE.rewardToken());

        TOKEN0.approve(address(PAIR), type(uint256).max);
        TOKEN1.approve(address(PAIR), type(uint256).max);
        IERC20(address(PAIR)).approve(address(GAUGE), type(uint256).max);

        DESCRIPTION = _description;
    }

    function _invest() internal override {
        uint deposit0;
        uint deposit1;
        {
            // Because pair requires a certain proportion of the tokens for the deposit we can't just deposit all
            // the tokens we have on our balance. We need to deposit them in accordance to the pair's ratio
            uint balance0 = TOKEN0.balanceOf(address(this));
            uint balance1 = TOKEN1.balanceOf(address(this));
            (uint reserve0, uint reserve1,) = PAIR.getReserves();
            if(reserve0 == 0 || reserve1 == 0){
                revert ZeroReserveBalance(reserve0,reserve1);
            }

            deposit0 = balance0;
            deposit1 = deposit0 * reserve1 / reserve0;

            if (deposit1 > balance1) {
                deposit1 = balance1;
                deposit0 = deposit1 * reserve0 / reserve1;
            }
        }

        SafeERC20.safeTransfer(TOKEN0, address(PAIR), deposit0);
        SafeERC20.safeTransfer(TOKEN1, address(PAIR), deposit1);
        PAIR.mint(address(this));
        GAUGE.depositAll();
    }

    function _redeem(uint lpAmount, address to)
        internal
        override
        returns (address[] memory tokens, uint[] memory amounts)
    {
        GAUGE.withdraw(lpAmount);
        PAIR.transfer(address(PAIR), lpAmount);
        (uint amount0, uint amount1) = PAIR.burn(to);

        tokens = depositTokens();

        amounts = new uint[](2);
        amounts[0] = amount0;
        amounts[1] = amount1;
    }

    function _claimAll() internal override {
        GAUGE.getReward();
    }

    function value() public override view returns (uint _estimatedValue, uint _lps) {
        (uint reserve0, uint reserve1,) = PAIR.getReserves();
        (uint value0, uint value1) = _values(reserve0, reserve1);

        _lps = GAUGE.balanceOf(address(this));
        _estimatedValue = (value0 + value1) * _lps / PAIR.totalSupply();
    }

    function negotiableTokens() public virtual override returns(address[] memory tokens) {
        tokens = new address[](3);
        tokens[0] = address(TOKEN0);
        tokens[1] = address(TOKEN1);
        tokens[2] = address(REWARD_TOKEN);
    }

    function depositTokens() public override view returns (address[] memory tokens) {
        tokens = new address[](2);
        tokens[0] = address(TOKEN0);
        tokens[1] = address(TOKEN1);
    }

    /// @notice returns amount of pending rewards in the reward token
    /// @dev for offchain use
    function pendingRewards() external override view returns(address[] memory tokens, uint[] memory amounts) {
        tokens  = new address[](1);
        tokens[0] = address(REWARD_TOKEN);

        amounts = new uint[](1);
        amounts[0] = GAUGE.earned(address(this));
    }

    /// @dev for offchain use
    function ratios() external override view returns (address[] memory tokens, uint[] memory ratio) {
        tokens = depositTokens();
        ratio = new uint[](2);
        (ratio[0], ratio[1], ) = PAIR.getReserves();
    }

    /// @dev for offchain use
    function description() external override view returns (string memory) {
        return DESCRIPTION;
    }

    function _values(uint256 _amount0, uint256 _amount1) internal view virtual returns (uint256 _value0, uint256 _value1);

}