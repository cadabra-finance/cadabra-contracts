// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin/utils/Address.sol";

import "./interfaces/IBalancer.sol";
import "./interfaces/IWETH.sol";
import "./interfaces/IRouter.sol";
import "./helpers/SwapExecutor.sol";

contract Router is IRouter {

    address constant ETH_IDENTIFIER = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
    address public immutable weth;
    SwapExecutor public immutable swapExecutor;

    constructor(address _weth, address _swapExecutor) {
        weth = _weth;
        swapExecutor = SwapExecutor(_swapExecutor);
    }

    receive() external payable {}

    function investWithSwaps(
        address adapter,
        address balancer,
        address tokenIn,
        uint256 amountIn,
        uint256 minShareAmount,
        SwapInfo[] calldata swaps
    ) external payable override returns (uint sharesAdded) {
        if (tokenIn == ETH_IDENTIFIER) {
            if (amountIn != msg.value) {
                revert IncorrectDepositAmount(msg.value, amountIn);
            }
            IWETH(weth).deposit{value: msg.value}();
            tokenIn = weth;
        } else {
            SafeERC20.safeTransferFrom(
                IERC20(tokenIn),
                msg.sender,
                address(this),
                amountIn
            );
        }
        IBalancer.SwapInfo[] memory bSwaps = new IBalancer.SwapInfo[](swaps.length);
        uint256 transferAmount = 0;
        for (uint i = 0; i < swaps.length; i++) {
            transferAmount += swaps[i].swapAmount;
            bSwaps[i] = IBalancer.SwapInfo(swaps[i].swapCallee, swaps[i].swapData, swaps[i].swapAmount, tokenIn);
        }

        uint restAmount = IERC20(tokenIn).balanceOf(address(this));
        SafeERC20.safeTransfer(IERC20(tokenIn), adapter, restAmount);

        sharesAdded = IBalancer(balancer).invest(adapter, msg.sender);

        if (sharesAdded < minShareAmount) {
            revert InsufficientSharesMinted(sharesAdded, minShareAmount);
        }
    }

    function investSingleSwap(
        address adapter,
        address balancer,
        address tokenIn,
        uint256 amountIn,
        uint256 minShareAmount,
        SwapInfo calldata swap
    ) external override payable returns (uint sharesAdded) {
        if (tokenIn == ETH_IDENTIFIER) {
            if (amountIn != msg.value) {
                revert IncorrectDepositAmount(msg.value, amountIn);
            }
            IWETH(weth).deposit{value: msg.value}();
            tokenIn = weth;
        } else {
            SafeERC20.safeTransferFrom(IERC20(tokenIn), msg.sender, address(this), amountIn);
        }

        SafeERC20.safeTransfer(IERC20(tokenIn), address(swapExecutor), swap.swapAmount);
        IBalancer.SwapInfo[] memory bSwaps = new IBalancer.SwapInfo[](1);
        bSwaps[0] = IBalancer.SwapInfo(swap.swapCallee, swap.swapData, swap.swapAmount, tokenIn);
        swapExecutor.executeSwaps(bSwaps);

        SafeERC20.safeTransfer(IERC20(tokenIn), adapter, amountIn - swap.swapAmount);

        sharesAdded = IBalancer(balancer).invest(adapter, msg.sender);

        if (sharesAdded < minShareAmount) {
            revert InsufficientSharesMinted(sharesAdded, minShareAmount);
        }    
    }

    function investTwoSwap(
        address adapter,
        address balancer,
        address tokenIn,
        uint256 amountIn,
        uint256 minShareAmount,
        SwapInfo calldata firstSwap,
        SwapInfo calldata secondSwap
    ) external override payable returns (uint sharesAdded) {
        if (tokenIn == ETH_IDENTIFIER) {
            if (amountIn != msg.value) {
                revert IncorrectDepositAmount(msg.value, amountIn);
            }            
            IWETH(weth).deposit{value: msg.value}();
            tokenIn = weth;
        } else {
            SafeERC20.safeTransferFrom(IERC20(tokenIn), msg.sender, address(this), amountIn);
        }

        SafeERC20.safeTransfer(IERC20(tokenIn), address(swapExecutor), firstSwap.swapAmount + secondSwap.swapAmount);
        IBalancer.SwapInfo[] memory bSwaps = new IBalancer.SwapInfo[](2);
        bSwaps[0] = IBalancer.SwapInfo(firstSwap.swapCallee, firstSwap.swapData, firstSwap.swapAmount, tokenIn);
        bSwaps[1] = IBalancer.SwapInfo(secondSwap.swapCallee, secondSwap.swapData, secondSwap.swapAmount, tokenIn);
        swapExecutor.executeSwaps(bSwaps);

        sharesAdded = IBalancer(balancer).invest(adapter, msg.sender);

        if (sharesAdded < minShareAmount) {
            revert InsufficientSharesMinted(sharesAdded, minShareAmount);
        }
    }
}