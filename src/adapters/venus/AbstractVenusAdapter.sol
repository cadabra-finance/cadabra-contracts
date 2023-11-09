// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";

import "./../BaseAdapter.sol";
import "../../interfaces/IAdapter.sol";
import "../../interfaces/venus/VBep20Delegator.sol";
import "../../interfaces/venus/Comptroller.sol";
import "../../interfaces/venus/VenusLens.sol";

abstract contract AbstractVenusAdapter is BaseAdapter {

    using SafeERC20 for IERC20;

    Comptroller     public immutable COMPTROLLER;
    VBep20Delegator public immutable VTOKEN;
    IERC20          public immutable REWARD_TOKEN;
    IERC20          public immutable UNDERLYING_TOKEN;
    VenusLens       public immutable VENUS_LENS;

    constructor(address _balancer, address _vToken, address _venusLens) BaseAdapter(_balancer) {
        VTOKEN = VBep20Delegator(_vToken);
        COMPTROLLER = Comptroller(VTOKEN.comptroller());
        UNDERLYING_TOKEN = IERC20(VTOKEN.underlying());
        REWARD_TOKEN = IERC20(COMPTROLLER.getXVSAddress());
        VENUS_LENS = VenusLens(_venusLens);
    }

    function _invest() internal override {
        uint depositAmount = UNDERLYING_TOKEN.balanceOf(address(this));
        if (depositAmount > 0) {
            UNDERLYING_TOKEN.forceApprove(address(VTOKEN), depositAmount);
            VTOKEN.mint(depositAmount);
        }
    }

    function _redeem(
        uint256 lpAmount,
        address to
    ) internal override returns (address[] memory tokens, uint[] memory amounts) {
        uint underlyingAmount = UNDERLYING_TOKEN.balanceOf(address(this));
        VTOKEN.redeem(lpAmount);
        underlyingAmount = UNDERLYING_TOKEN.balanceOf(address(this)) - underlyingAmount;
        UNDERLYING_TOKEN.safeTransfer(to, underlyingAmount);

        tokens = new address[](1);
        tokens[0] = address(UNDERLYING_TOKEN);

        amounts = new uint[](1);
        amounts[0] = underlyingAmount;
    }

    function _claimAll() internal override {
        COMPTROLLER.claimVenus(address(this));
    }

    function negotiableTokens() public override returns(address[] memory tokens) {
        tokens = new address[](3);
        tokens[0] = address(VTOKEN);
        tokens[1] = address(UNDERLYING_TOKEN);
        tokens[2] = address(REWARD_TOKEN);
    }

    function depositTokens() public override view returns (address[] memory tokens) {
        tokens = new address[](1);
        tokens[0] = address(UNDERLYING_TOKEN);
    }

    function value() public view override returns (uint estimatedValue, uint lpAmount) {
        lpAmount = VTOKEN.balanceOf(address(this));
        estimatedValue = _value(_convertToUnderlying(lpAmount));
    }

    function pendingRewards() external view override returns(address[] memory tokens, uint[] memory amounts) {
        VenusLens.RewardSummary memory summary = VENUS_LENS.pendingRewards(address(this), address(COMPTROLLER));
        uint totalRewards = summary.totalRewards;

        uint pendingLength = summary.pendingRewards.length;
        for (uint i = 0; i < pendingLength; ++i) {
            VenusLens.PendingReward memory pending = summary.pendingRewards[i];
            totalRewards += pending.amount;
        }

        tokens = new address[](1);
        tokens[0] = address(REWARD_TOKEN);

        amounts = new uint[](1);
        amounts[0] = totalRewards;
    }

    function ratios() external view override returns(address[] memory tokens, uint[] memory ratio) {
        tokens = new address[](1);
        tokens[0] = address(UNDERLYING_TOKEN);

        ratio  = new uint[](1);
        ratio[0] = 1e18;
    }

    function description() external override returns (string memory) {
        return string.concat(
            '{"type":"venusSupply","vaultAddress":"',
            Strings.toHexString(address(VTOKEN)),
            ',"comptrollerAddress":"',
            Strings.toHexString(address(COMPTROLLER)),
            ',"lensAddress":"',
            Strings.toHexString(address(VENUS_LENS)),
            ',"underlyingAddress":"',
            Strings.toHexString(address(UNDERLYING_TOKEN)),
            '"}'
        );
    }

    function _value(uint256 amount) internal view virtual returns (uint256 value);

    function _convertToUnderlying(uint256 lpAmount) internal view returns (uint256 underlyingAmount) {
        return VTOKEN.exchangeRateStored() * lpAmount / 1e18;
    }

}