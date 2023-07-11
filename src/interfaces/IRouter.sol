// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IRouter {

    struct SwapInfo {
        address swapCallee;
        bytes swapData;
        uint256 swapAmount;
    }

    error InsufficientSharesMinted(uint minted, uint minAmount);
    error IncorrectDepositAmount(uint has, uint wants);

    function investWithSwaps(
        address adapter,
        address balancer,
        address tokenIn,
        uint256 amountIn,
        uint256 minShareAmount,
        SwapInfo[] calldata swaps
    ) external payable returns (uint sharesAdded);

    function investSingleSwap(
        address adapter,
        address balancer,
        address tokenIn,
        uint256 amountIn,
        uint256 minShareAmount,
        SwapInfo calldata swap
    ) external payable returns (uint sharesAdded);

    function investTwoSwap(
        address adapter,
        address balancer,
        address tokenIn,
        uint256 amountIn,
        uint256 minShareAmount,
        SwapInfo calldata firstSwap,
        SwapInfo calldata secondSwap
    ) external payable returns (uint sharesAdded);

}