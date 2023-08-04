// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library ChainLinkLib {
    error OracleStalePrice(uint answeredAt);
    error OracleZeroOrNegativePrice(int price);

    function getPrice(AggregatorV3Interface feed, uint stalePriceInterval) internal view returns (uint256 price) {
        // TODO: L2 https://twitter.com/bytes032/status/1653943092427325448
        // https://docs.chain.link/data-feeds/l2-sequencer-feeds
        
        (, int256 answer, , uint256 updatedAt,) = feed.latestRoundData();
        if ((block.timestamp - updatedAt) > stalePriceInterval) {
            revert OracleStalePrice(updatedAt);
        }
        if (answer < 1) {
            revert OracleZeroOrNegativePrice(answer);
        }

        uint256 d = feed.decimals();
        price = d <= 18 ? uint(answer)*(10**(18 - d)) : uint(answer)/(10**(d - 18));
    }
}