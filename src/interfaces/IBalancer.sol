// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./IAdapter.sol";

interface IBalancer {

    struct SwapInfo {
        address callee; // 1inch callee
        bytes data; // 1inch swap data
        uint256 amount; // amount to swap
        address token; // token to swap
    }

    struct TransferInfo {
        uint256 amount; // amount to transfer
        address token; // token to transfer
    }

    struct AdapterCache {
        uint value;    // equivalent value
        uint lpAmount; // amount of controlled underlying LP tokens
    }

    event Invest(address indexed adapter, address from, uint totalValueBefore, uint valueAdded, uint sharesWithFee, uint sharesMinted);
    event Redeem(address indexed adapter, address to, uint shares, uint totalValueBefore, uint valueSubtracted);
    event Rebalance(address indexed fromAdapter, address indexed toAdapter, uint amount);
    event ProfitLocked(uint valueBefore, uint profitLocked, uint feeLocked, uint lockedUntil);
    event AdapterActivityChanged(address adapter, bool active);
    event AdapterAdded(address adapter);
    event AdapterRemoved(address adapter);
    event FeeReceiverChanged(address oldFeeReceiver, address newFeeReceiver);
    event Compound(address adapter, uint totalValueBefore, uint valueAdded, uint fee);
    event TakePerformanceFee(uint112 feeValue, uint totalValue);

    error InsufficientFunds(uint has, uint wants);
    error AdapterRedeemExceeds(uint adapterValue, uint redeemValue);
    error EmptyRedeem(uint shares, uint redeemValue, address adapter, uint adapterValue, uint adapterLpAmount);
    error SharesInflationError(uint valueAdded, uint valuePrior);
    error InvalidAdapter(address adapter);
    error ValueLost(uint diff);
    error MinRebalanceSlippageExceeds(uint minRebalancedValue, uint actualValueAfter);
    error Cooldown(uint until);
    error AdapterNotEmpty(address adapter);
    error DeactivationFailed(address adapter);
    error InvalidPerformanceFee(uint performanceFee);
    error HugePerformanceFee(uint performanceFee, uint totalValue);
    error InsufficientLiquidityAdded(uint has, uint wants);
    error Expired(uint deadline);

    function invest(address targetAdapter, address receiver) external returns (uint sharesAdded);
    function redeem(uint shares, IAdapter targetAdapter, address receiver)
        external
        returns (
            address[] memory tokens,
            uint[] memory amounts
        );
    function totalNAV() external view returns (uint nav, uint112 lockedProfit, uint112 lockedFee);
    function totalValue() external view returns (uint value);
    function adapters() external view returns (address[] memory);
    function chargedAdapters() external view returns (address[] memory);
    function swapExecutor() external view returns(address);

    //╔═══════════════════════════════════════════ ADMINISTRATIVE FUNCTIONS ═══════════════════════════════════════════╗
    function rebalance(
        IAdapter fromAdapter,
        IAdapter toAdapter,
        uint amount,
        SwapInfo[] calldata swaps,
        TransferInfo[] calldata transfers,
        uint minRebalancedValue,
        uint32 deadline
    ) external;
    function compound(
        address adapter, 
        uint performanceFee, 
        SwapInfo[] calldata swaps, 
        uint256 minValue, 
        uint32 deadline
    ) external returns (uint addedValue);

    function addAdapter(address adapterAddress) external returns (bool);
    function removeAdapter(address adapterAddress) external returns (bool);
    function activateAdapter(address adapterAddress) external returns (bool);
    function deactivateAdapter(address adapterAddress) external;
    function setFeeReceiver(address feeReceiver_) external;
    function takePerformanceFee(uint112 feeValue) external;
    function recoverFunds(address adapter, TransferInfo calldata transfer, address to) external;   

}
