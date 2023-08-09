// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "openzeppelin/utils/math/SafeCast.sol";
import "chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "./ThenaGammaAdapter.sol";
import "../helpers/TwapUtils.sol";
import "../interfaces/thena/IGammaHypervisor.sol";
import "../libraries/ChainLinkLibrary.sol";

contract ThenaGammaToken0TWAPAdapter is ThenaGammaAdapter {
    
    using SafeCast for int256;
    using ChainLinkLib for AggregatorV3Interface;

    AggregatorV3Interface public immutable TOKEN1_PRICE_FEED;
    uint public immutable FEED_STALE_PRICE_INTERVAL;
    address public immutable POOL;

    constructor(
        address _balancer, 
        address _gauge, 
        address _token1PriceFeed,
        uint    _feedStaleInterval
    ) ThenaGammaAdapter(
        _balancer,
        _gauge) {
        TOKEN1_PRICE_FEED = AggregatorV3Interface(_token1PriceFeed);
        FEED_STALE_PRICE_INTERVAL = _feedStaleInterval;
        POOL = address(HYPERVISOR.pool());
    }

    function token0Price() public virtual view override returns (uint256)  {
        uint twap = TwapUtils.getTwap(POOL, 15, token0Decimals());
        return twap * token1Price() / 1e18 ;
    }

    function token1Price() public virtual view override returns (uint256) {
        return TOKEN1_PRICE_FEED.getL1Price(FEED_STALE_PRICE_INTERVAL);
    }

}
