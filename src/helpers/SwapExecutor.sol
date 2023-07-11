// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/utils/Address.sol";

import "../interfaces/IBalancer.sol";

contract SwapExecutor {

    function executeSwaps(IBalancer.SwapInfo[] calldata swaps) public {
        for (uint i = 0; i < swaps.length; i++) {
            IBalancer.SwapInfo calldata swap = swaps[i];
            IERC20(swap.token).approve(swap.callee, swap.amount);
            Address.functionCall(swap.callee, swap.data);
        }
    }

}
