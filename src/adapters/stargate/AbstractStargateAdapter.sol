// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/extensions/IERC20Metadata.sol";
import "openzeppelin/utils/Address.sol";
import "openzeppelin/utils/math/SafeCast.sol";
import "openzeppelin/utils/Strings.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";

import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "../BaseAdapter.sol";
import "../../interfaces/IAdapter.sol";
import "../../interfaces/stargate/ILPStaking.sol";
import "../../interfaces/stargate/IRouter.sol";
import "../../interfaces/stargate/IPool.sol";
import "../../interfaces/IBalancer.sol";
import "../../libraries/ChainLinkLibrary.sol";
import "../../helpers/SwapExecutor.sol";

abstract contract AbstractStargateAdapter is BaseAdapter {
    using SafeERC20 for IERC20;
    using SafeCast for int256;
    using ChainLinkLib for AggregatorV3Interface;

    ILPStaking public immutable LPSTAKING;
    IRouter public immutable ROUTER;
    IPool public immutable POOL;
    IERC20 public immutable TOKEN;
    IERC20 public immutable REWARD_TOKEN;

    uint public immutable POOL_ID; // LpStaking parameter of pools. It use to stake liquidity. 
    uint public immutable CHAIN_POOL_ID; // Pool parameter. use to add liquidity. "shared id between chains to represent same pool" @Stargate

    constructor(
        address _balancer,
        address _lpstaking,
        uint _poolId
    ) BaseAdapter(_balancer) {
        LPSTAKING = ILPStaking(_lpstaking);
        (address _pool,,,) = LPSTAKING.poolInfo(_poolId);
        POOL = IPool(_pool);
        ROUTER = IRouter(POOL.router());

        TOKEN = IERC20(POOL.token());
        REWARD_TOKEN = IERC20(LPSTAKING.stargate());
        POOL_ID = _poolId;
        CHAIN_POOL_ID = POOL.poolId();

        TOKEN.approve(address(ROUTER), type(uint256).max);
        POOL.approve(_lpstaking, type(uint256).max);
    }

    function _invest() internal override {
        uint256 balance = TOKEN.balanceOf(address(this));

        ROUTER.addLiquidity(CHAIN_POOL_ID, balance, address(this));

        uint amount = POOL.balanceOf(address(this));
        require(amount > 0);
        LPSTAKING.deposit(POOL_ID, amount);
    }

    function _redeem(uint lpAmount, address to)
        internal
        override
        returns (address[] memory tokens, uint[] memory amounts)
    {
        LPSTAKING.withdraw(POOL_ID, lpAmount);

        uint convertRate = POOL.convertRate();
        uint amountSD = ROUTER.instantRedeemLocal(uint16(CHAIN_POOL_ID), lpAmount, to);

        tokens = new address[](1);
        amounts = new uint[](1);

        tokens[0] = address(TOKEN);

        amounts[0] = amountSD * convertRate;
    }

    function _claimAll() internal override {
        LPSTAKING.deposit(POOL_ID, 0);
    }

    function value() public override view returns (uint estimatedValue, uint lps) {
        uint tl = POOL.totalLiquidity();
        uint ts = POOL.totalSupply();
        uint convertRate = POOL.convertRate();
        (lps, ) = LPSTAKING.userInfo(POOL_ID, address(this));

        uint baseAmount = (tl * lps * convertRate) / ts;
        estimatedValue = _baseValue(baseAmount);
    }

    function _baseValue(uint _baseAmount) internal view virtual returns (uint);

    function negotiableTokens() public virtual override returns(address[] memory tokens) {
        tokens = new address[](2);
        tokens[0] = address(TOKEN);
        tokens[1] = address(REWARD_TOKEN);
    }

    function depositTokens() public override view returns (address[] memory tokens) {
        tokens = new address[](1);
        tokens[0] = address(TOKEN);
    }

    /// @notice returns amount of pending rewards in the reward token
    /// @dev for offchain use
    function pendingRewards()
        external
        view
        override
        returns (address[] memory tokens, uint[] memory amounts)
    {
        tokens = new address[](1);
        amounts = new uint[](1);

        tokens[0] = address(REWARD_TOKEN);
        amounts[0] = LPSTAKING.pendingStargate(POOL_ID, address(this));
    }

    /// @dev for offchain use
    function ratios()
        external
        view
        override
        returns (address[] memory tokens, uint[] memory ratio)
    {
        tokens = new address[](1);
        ratio = new uint[](1);

        tokens[0] = address(TOKEN);
        ratio[0] = 1e18; // 100%
    }

    /// @dev for offchain use
    function description() external view override returns (string memory) {
        return
            string.concat(
                '{"type":"stargate","vaultAddress": "',
                Strings.toHexString(address(LPSTAKING)),
                '"}'
            );
    }

}
