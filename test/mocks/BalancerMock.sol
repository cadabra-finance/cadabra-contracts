// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "../../src/helpers/SwapExecutor.sol";
import "../../src/interfaces/IAdapter.sol";

contract BalancerMock {

    SwapExecutor public immutable SWAP_EXECUTOR;

    constructor(address _swapExecutor) {
        SWAP_EXECUTOR = SwapExecutor(_swapExecutor);
    }

    function invest(IAdapter adapter, address dustReceiver)
        external
        returns (uint256 valueBefore, uint256 valueAfter)
    {
        return IAdapter(adapter).invest(dustReceiver);
    }

    function redeem(IAdapter adapter, uint256 lpAmount, address to)
        external
        virtual
        returns (address[] memory tokens, uint256[] memory amounts)
    {
        (tokens, amounts) = IAdapter(adapter).redeem(lpAmount, to);
    }

    function swapExecutor() external view returns (address) {
        return address(SWAP_EXECUTOR);
    }

    function compound(IAdapter adapter) external returns (uint leqBefore,uint leqAfter) {
        IBalancer.SwapInfo[] memory swaps = new IBalancer.SwapInfo[](0);
        return adapter.compound(swaps);
    }

}