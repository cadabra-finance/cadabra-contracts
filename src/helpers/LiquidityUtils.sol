// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

library LiquidityUtils {

    function ratio2(
        uint256 balance0, 
        uint256 balance1, 
        uint256 reserve0, 
        uint256 reserve1
    ) external pure returns (uint256 d0, uint256 d1) {
        // Decimal safe operations, but when ratios are highly skewed and one of the tokens has less decimals then
        // the other there can be a situation when d0 or d1 will be zero
        d0 = balance0;
        d1 = d0 * reserve1 / reserve0;

        if (d1 > balance1) {
            d1 = balance1;
            d0 = d1 * reserve0 / reserve1;
        }
    }

}