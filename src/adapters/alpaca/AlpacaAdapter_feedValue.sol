// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "../../libraries/ChainLinkLibrary.sol";
import "./AbstractAlpacaAdapter.sol";

contract AlpacaAdapter_feedValue is AbstractAlpacaAdapter {

    using ChainLinkLib for AggregatorV3Interface;

    uint public constant PRICE_DECIMALS = 18;

    AggregatorV3Interface public immutable BASE_PRICE_FEED;
    uint public immutable FEED_STALE_PRICE_INTERVAL;
    uint private immutable PRECISION_MULTIPLIER;

    constructor(
        address _balancer, 
        address _moneyMarket, 
        address _base,
        address _basePriceFeed,
        uint    _feedStaleInterval
    ) AbstractAlpacaAdapter(_balancer, _moneyMarket, _base) {
        BASE_PRICE_FEED = AggregatorV3Interface(_basePriceFeed);
        FEED_STALE_PRICE_INTERVAL = _feedStaleInterval;

        IERC20 base = IERC20(_base);
        uint8 decimals = IERC20Metadata(address(base)).decimals();
        if (decimals > PRICE_DECIMALS) {
            revert("UnsupportedToken");
        }
        PRECISION_MULTIPLIER = 10**decimals;
    }

    function _baseValue(uint _baseAmount) internal view override returns (uint) {
        uint price = BASE_PRICE_FEED.getL1Price(FEED_STALE_PRICE_INTERVAL);
        return _baseAmount * price / PRECISION_MULTIPLIER;    
    }

}