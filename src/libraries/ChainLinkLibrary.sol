// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library ChainLinkLib {

    uint256 private constant L2_SEQUENCER_STARTUP_PERIOD = 3600;

    error OracleStalePrice(uint answeredAt);
    error OracleZeroOrNegativePrice(int price);
    error SequencerDown();
    error SequencerNotReady();

    function getL1Price(AggregatorV3Interface feed, uint stalePriceInterval) internal view returns (uint256 price) {
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

    function getL2Price(AggregatorV3Interface feed, AggregatorV3Interface sequencerUptimeFeed, uint stalePriceInterval)
        internal
        view
        returns (uint256 price)
    {
        (
            /* uint80 roundID */,
            int256 sequencerAnswer,
            uint256 sequencerStartedAt,
            /* uint256 updatedAt */,
            /* uint80 answeredInRound */
        ) = sequencerUptimeFeed.latestRoundData();

        // answer == 0: sequencer is up; answer == 1: sequencer is down
        bool isSequencerDown = sequencerAnswer == 1;
        if (isSequencerDown) revert SequencerDown();

        bool isSequencerNotReady = block.timestamp - sequencerStartedAt <= L2_SEQUENCER_STARTUP_PERIOD;
        if (isSequencerNotReady) revert SequencerNotReady();

        return getL1Price(feed, stalePriceInterval);
    }

}