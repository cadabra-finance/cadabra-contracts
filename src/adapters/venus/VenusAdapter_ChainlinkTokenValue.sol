// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import 'chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol';
import '../../libraries/ChainLinkLibrary.sol';

import "./AbstractVenusAdapter.sol";

contract VenusAdapter_ChainlinkTokenValue is AbstractVenusAdapter {

    using ChainLinkLib for AggregatorV3Interface;

    uint public constant PRICE_DECIMALS = 18;

    AggregatorV3Interface   public immutable PRICE_FEED;
    uint                    public immutable FEED_STALE_PRICE_INTERVAL;
    uint                    private immutable PRECISION_MULTIPLIER;

    constructor(
        address _balancer,
        address _vToken,
        address _venusLens,
        address _priceFeed,
        uint    _feedStalePriceInterval
    ) AbstractVenusAdapter(_balancer, _vToken, _venusLens) {
        PRICE_FEED = AggregatorV3Interface(_priceFeed);
        FEED_STALE_PRICE_INTERVAL = _feedStalePriceInterval;

        uint8 decimals = IERC20Metadata(address(UNDERLYING_TOKEN)).decimals();
        if (decimals > PRICE_DECIMALS)
            revert UnsupportedToken({ token: address(UNDERLYING_TOKEN) });

        PRECISION_MULTIPLIER = 10**decimals;
    }

    function _value(uint amount) internal view override returns (uint) {
        uint price = PRICE_FEED.getL1Price(FEED_STALE_PRICE_INTERVAL);
        return amount * price / PRECISION_MULTIPLIER;
    }

}