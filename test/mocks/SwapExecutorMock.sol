// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/helpers/SwapExecutor.sol";
import "forge-std/console2.sol";
import "forge-std/StdAssertions.sol";
import "openzeppelin/token/ERC20/ERC20.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";

contract SwapExecutorMock is SwapExecutor, StdAssertions {
    using SafeERC20 for IERC20;

    // address private immutable FROM_TOKEN;
    address private immutable TO_TOKEN;
    uint256 private immutable CONVERSION_RATE_E18;

    constructor(uint24 _uniswapPoolFee, address _uniswapRouter, address toToken, uint256 conversionRateE18) 
    SwapExecutor(_uniswapPoolFee, _uniswapRouter) {
        // FROM_TOKEN = fromToken;
        TO_TOKEN = toToken;
        CONVERSION_RATE_E18 = conversionRateE18;
    }

    function defaultSwap(
        address fromToken,
        address toToken,
        uint256
    ) external override returns (uint256 toAmount) {
        // assertEq(FROM_TOKEN, fromToken, "Unexpected fromToken");
        assertEq(TO_TOKEN, toToken, "Unexpected toToken");
        uint256 fromAmount = IERC20(fromToken).allowance(msg.sender, address(this));
        toAmount = fromAmount * CONVERSION_RATE_E18 / 1e18;
        // console2.log("default swap from amount:", fromAmount, "to amount:", toAmount);
        IERC20(fromToken).safeTransferFrom(msg.sender, address(this), fromAmount);
        IERC20(toToken).safeTransfer(msg.sender, toAmount);
    }
}
