// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./ThenaGammaAdapter.sol";
import "../libraries/TwapUtils.sol";
import "../interfaces/thena/IPair.sol";

contract ThenaGammaAdapter_qStablePair is ThenaGammaAdapter {

    address private immutable POOL;
    bool    private immutable IS_TOKEN1_QUOTE;
    IPair   private immutable QUOTE_PAIR;

    constructor(
        address _balancer, 
        address _gauge,
        address _quotePair,
        address _quoteToken
    ) ThenaGammaAdapter(_balancer, _gauge) {
        POOL = address(HYPERVISOR.pool());
        IS_TOKEN1_QUOTE = _isToken1Quote(_quoteToken);
        QUOTE_PAIR = IPair(_quotePair);
    }

    function _isToken1Quote(address _quoteToken) private view returns (bool) {
        if (address(TOKEN0) == _quoteToken) {
            return false;
        } else if (address(TOKEN1) == _quoteToken) {
            return true;
        } else {
            revert UnsupportedToken({ token: _quoteToken });
        }
    }

    function token0Price() public virtual view override returns (uint256)  {
        if (IS_TOKEN1_QUOTE) {
            uint256 price1 = QUOTE_PAIR.current(address(TOKEN1), PRICE_DECIMALS);
            return TwapUtils.convertToken0ToToken1(price1, POOL, 15);
        } else {
            return QUOTE_PAIR.current(address(TOKEN0), PRICE_DECIMALS);
        }
    }

    function token1Price() public view virtual override returns (uint256) {
        if (IS_TOKEN1_QUOTE) {
            return QUOTE_PAIR.current(address(TOKEN1), PRICE_DECIMALS);
        } else {
            uint256 price0 = QUOTE_PAIR.current(address(TOKEN0), PRICE_DECIMALS);
            return TwapUtils.convertToken1ToToken0(price0, POOL, 15);
        }
    }

}
