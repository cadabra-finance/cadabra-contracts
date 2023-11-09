// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "openzeppelin/utils/math/SafeCast.sol";
import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "../libraries/ChainLinkLibrary.sol";

import "./ThenaGammaAdapter.sol";

contract ThenaGammaPriceFeedAdapter is ThenaGammaAdapter {
    
    using SafeCast for int256;
    using ChainLinkLib for AggregatorV3Interface;

    AggregatorV3Interface public immutable TOKEN0_PRICE_FEED;
    AggregatorV3Interface public immutable TOKEN1_PRICE_FEED;
    uint public immutable FEED_STALE_PRICE_INTERVAL;

    constructor(
        address _balancer, 
        address _gauge, 
        address _token0PriceFeed,
        address _token1PriceFeed,
        uint    _feedStaleInterval
    ) ThenaGammaAdapter(
        _balancer,
        _gauge) {
        TOKEN0_PRICE_FEED = AggregatorV3Interface(_token0PriceFeed);
        TOKEN1_PRICE_FEED = AggregatorV3Interface(_token1PriceFeed);
        FEED_STALE_PRICE_INTERVAL = _feedStaleInterval;
    }

    function token0Price() public virtual view override returns (uint256)  {
        return TOKEN0_PRICE_FEED.getL1Price(FEED_STALE_PRICE_INTERVAL);
    }

    function token1Price() public virtual view override returns (uint256) {
        return TOKEN1_PRICE_FEED.getL1Price(FEED_STALE_PRICE_INTERVAL);
    }

}
