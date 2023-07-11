// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "./TickMath.sol";
import "./FullMath.sol";

import "openzeppelin/utils/math/SafeCast.sol";

interface IPool {
  function getTimepoints(uint32[] memory secondsAgos) external view returns (int56[] memory tickCumulatives, uint160[] memory secondsPerLiquidityCumulatives, uint112[] memory volatilityCumulatives, uint256[] memory volumePerAvgLiquiditys);
  function globalState()
    external
    view
    returns (uint160 price, int24 tick, int24 prevInitializedTick, uint16 fee, uint16 timepointIndex, uint8 communityFee, bool unlocked);
}

library TwapUtils {
    
    uint256 internal constant Q96 = 1 << 96;
    uint256 internal constant Q192 = 1 << 192;

    function getTwap(address uniswapV3Pool, uint32 twapInterval, uint8 decimalsToken0) public view returns(uint256 priceX96) {
        return sqrtPriceX96ToUint(getSqrtTwapX96(uniswapV3Pool, twapInterval), decimalsToken0);
    }

    function convertToken0ToToken1(uint256 token0Amount, address uniswapV3Pool, uint32 twapInterval) public view returns(uint256 token1Amount) {
        token1Amount = convertWithDirectSqrtPrice(token0Amount, getSqrtTwapX96(uniswapV3Pool, twapInterval));
    }

    function convertToken1ToToken0(uint256 token1Amount, address uniswapV3Pool, uint32 twapInterval) public view returns(uint256 token0Amount) {
        token0Amount = convertWithReverseSqrtPrice(token1Amount, getSqrtTwapX96(uniswapV3Pool, twapInterval));
    }

    function getSqrtTwapX96(address uniswapV3Pool, uint32 twapInterval) public view returns (uint160 sqrtPriceX96) {
        if (twapInterval == 0) {
            uint32[] memory secondsAgos = new uint32[](1);
            secondsAgos[0] = 0;

            (sqrtPriceX96,,,,,,) = IPool(uniswapV3Pool).globalState();
        } else {
            uint32[] memory secondsAgos = new uint32[](2);
            secondsAgos[0] = twapInterval; // from (before)
            secondsAgos[1] = 0; // to (now)

            (int56[] memory tickCumulatives,,, ) = IPool(uniswapV3Pool).getTimepoints(secondsAgos);

            // tick(imprecise as it's an integer) to price
            sqrtPriceX96 = TickMath.getSqrtRatioAtTick(
                int24((tickCumulatives[1] - tickCumulatives[0]) / SafeCast.toInt56(SafeCast.toInt256(uint256(twapInterval))))
            );
        }
    }

    function sqrtPriceX96ToUint(uint160 sqrtPriceX96, uint8 decimalsToken0) public pure returns (uint256)
    {
        return convertWithDirectSqrtPrice(10**decimalsToken0, sqrtPriceX96);
    }

    function convertWithDirectSqrtPrice(uint256 amount, uint160 sqrtPriceX96) public pure returns (uint256)
    {
        uint256 priceX192 = uint256(sqrtPriceX96) * uint256(sqrtPriceX96);
        return FullMath.mulDiv(amount, priceX192, Q192);
    }

    function convertWithReverseSqrtPrice(uint256 amount, uint160 sqrtPriceX96) public pure returns (uint256)
    {
        uint256 priceX192 = uint256(sqrtPriceX96) * uint256(sqrtPriceX96);
        return FullMath.mulDiv(amount, Q192, priceX192);
    }

}