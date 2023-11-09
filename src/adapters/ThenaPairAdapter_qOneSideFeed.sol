// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import 'openzeppelin/utils/math/SafeCast.sol';
import 'chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol';
import '../libraries/ChainLinkLibrary.sol';

import './ThenaPairAdapter.sol';

contract ThenaPairAdapter_qOneSideFeed is ThenaPairAdapter {

    using ChainLinkLib for AggregatorV3Interface;

    uint public constant PRICE_DECIMALS    = 18;
    uint public constant PRICE_BASE        = 1e18;

    bool                    public immutable IS_TOKEN1_QUOTE;
    AggregatorV3Interface   public immutable QUOTE_PRICE_FEED;
    uint                    public immutable FEED_STALE_PRICE_INTERVAL;
    uint                    public immutable PRICE_BASE0;
    uint                    public immutable PRICE_BASE1;

    constructor(
        address _balancer,
        address _gauge,
        address _quoteToken,
        address _quotePriceFeed,
        uint    _feedStalePriceInterval,
        string  memory _description
    ) ThenaPairAdapter(_balancer, _gauge, _description) {
        IS_TOKEN1_QUOTE = _isToken1Quote(_quoteToken);
        QUOTE_PRICE_FEED = AggregatorV3Interface(_quotePriceFeed);
        FEED_STALE_PRICE_INTERVAL = _feedStalePriceInterval;

        uint8 decimals0 = IERC20Metadata(address(TOKEN0)).decimals();
        uint8 decimals1 = IERC20Metadata(address(TOKEN1)).decimals();
        if (decimals0 > PRICE_DECIMALS) revert UnsupportedToken({ token: address(TOKEN0) });
        if (decimals1 > PRICE_DECIMALS) revert UnsupportedToken({ token: address(TOKEN1) });

        PRICE_BASE0 = 10**decimals0;
        PRICE_BASE1 = 10**decimals1;
    }

    function _isToken1Quote(address _quoteToken) private view returns (bool) {
        if (_quoteToken == address(TOKEN0)) {
            return false;
        } else if (_quoteToken == address(TOKEN1)) {
            return true;
        } else {
            revert UnsupportedToken({ token: _quoteToken });
        }
    }

    function _values(uint256 _amount0, uint256 _amount1) internal view override returns (uint256 _value0, uint256 _value1) {
        uint quotePrice = QUOTE_PRICE_FEED.getL1Price(FEED_STALE_PRICE_INTERVAL);
        if (IS_TOKEN1_QUOTE) {
            uint price0 = PAIR.current(address(TOKEN0), PRICE_BASE0) * quotePrice / PRICE_BASE1;
            _value0 = _amount0 * price0 / PRICE_BASE0;
            _value1 = _amount1 * quotePrice / PRICE_BASE1;
        } else {
            uint price1 = PAIR.current(address(TOKEN1), PRICE_BASE1) * quotePrice / PRICE_BASE0;
            _value0 = _amount0 * quotePrice / PRICE_BASE0;
            _value1 = _amount1 * price1 / PRICE_BASE1;
        }
    }

}