// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "./VelodromePoolAdapter.sol";
import "../interfaces/velodrome/IPool.sol";
import "../libraries/VelodromeUtils.sol";

contract VelodromePoolAdapter_qStablePair is VelodromePoolAdapter {

    uint public constant PRICE_DECIMALS    = 18;
    uint public constant PRICE_BASE        = 1e18;

    IPool   public immutable QUOTE_POOL;
    bool    public immutable IS_TOKEN1_CONVERTIBLE_IN_BASE_POOL;
    bool    public immutable IS_TOKEN1_QUOTE_IN_QUOTE_POOL;
    bool    public immutable IS_BASE_POOL_STABLE;
    bool    public immutable IS_QUOTE_POOL_STABLE;
    uint    public immutable BASE0;
    uint    public immutable BASE1;
    uint    public immutable QUOTE_BASE;
    uint    public immutable QUOTE_PRICE_FACTOR;

    constructor(
        address _balancer,
        address _gauge,
        address _quotePool,
        address _convertibleToken
    ) VelodromePoolAdapter(_balancer, _gauge) {
        QUOTE_POOL = IPool(_quotePool);
        IS_BASE_POOL_STABLE = POOL.stable();
        IS_QUOTE_POOL_STABLE = QUOTE_POOL.stable();

        uint8 decimals0 = IERC20Metadata(address(TOKEN0)).decimals();
        uint8 decimals1 = IERC20Metadata(address(TOKEN1)).decimals();
        if (decimals0 > PRICE_DECIMALS) revert UnsupportedToken({ token: address(TOKEN0) });
        if (decimals1 > PRICE_DECIMALS) revert UnsupportedToken({ token: address(TOKEN1) });

        BASE0 = 10**decimals0;
        BASE1 = 10**decimals1;

        (address quoteToken, uint8 quoteDecimals, bool isToken1QuoteInQuotePool) = _getQuoteTokenInfo(_convertibleToken);
        QUOTE_BASE = 10**quoteDecimals;
        QUOTE_PRICE_FACTOR = 10**(PRICE_DECIMALS - quoteDecimals);

        IS_TOKEN1_CONVERTIBLE_IN_BASE_POOL = _isToken1ConvertibleInBasePool(_convertibleToken);
        IS_TOKEN1_QUOTE_IN_QUOTE_POOL = isToken1QuoteInQuotePool;
    }

    function _isToken1ConvertibleInBasePool(address _convertibleToken) private view returns (bool) {
        if (address(TOKEN0) == _convertibleToken) {
            return false;
        } else if (address(TOKEN1) == _convertibleToken) {
            return true;
        } else {
            revert UnsupportedToken({ token: _convertibleToken });
        }
    }

    function _getQuoteTokenInfo(address _convertibleToken) private view returns (address, uint8, bool) {
        (address qToken0Address, address qToken1Address) = QUOTE_POOL.tokens();
        if (qToken0Address == _convertibleToken) {
            return (qToken1Address, IERC20Metadata(qToken1Address).decimals(), true);
        } else if (qToken1Address == _convertibleToken) {
            return (qToken0Address, IERC20Metadata(qToken0Address).decimals(), false);
        } else {
            revert UnsupportedToken({ token: _convertibleToken });
        }
    }

    function _values(uint256 _amount0, uint256 _amount1) internal view override returns (uint256 _value0, uint256 _value1) {
        (uint r0, uint r1) = VelodromeUtils.reserves(address(POOL));
        (uint qr0, uint qr1) = VelodromeUtils.reserves(address(QUOTE_POOL));

        uint price0;
        uint price1;

        // BASE_POOL has (t0, t1) tokens, QUOTE_POOL has (qt0, qt1) tokens
        if (IS_TOKEN1_CONVERTIBLE_IN_BASE_POOL) {
            if (IS_TOKEN1_QUOTE_IN_QUOTE_POOL) {
                // t1 == qt0 - convertible token, qt1 - quote token
                // price0 = convert{qt0 -> qt1}( convert{t0 -> t1}(base0) )
                price0 = VelodromeUtils.amount1(BASE0, BASE0, BASE1, r0, r1, IS_BASE_POOL_STABLE);
                price0 = VelodromeUtils.amount1(price0, BASE1, QUOTE_BASE, qr0, qr1, IS_QUOTE_POOL_STABLE);
                // price1 = convert{qt0 -> qt1}(base1)
                price1 = VelodromeUtils.amount1(BASE1, BASE1, QUOTE_BASE, qr0, qr1, IS_QUOTE_POOL_STABLE);
            } else {
                // t1 == qt1 - convertible token, qt0 - quote token
                // price0 = convert{qt1 -> qt0}( convert{t0 -> t1}(base0) )
                price0 = VelodromeUtils.amount1(BASE0, BASE0, BASE1, r0, r1, IS_BASE_POOL_STABLE);
                price0 = VelodromeUtils.amount0(price0, QUOTE_BASE, BASE1, qr0, qr1, IS_QUOTE_POOL_STABLE);
                // price1 = convert{qt1 -> qt0}(base1)
                price1 = VelodromeUtils.amount0(BASE1, QUOTE_BASE, BASE1, qr0, qr1, IS_QUOTE_POOL_STABLE);
            }
        } else {
            if (IS_TOKEN1_QUOTE_IN_QUOTE_POOL) {
                // t0 == qt0 - convertible token, qt1 - quote token
                // price0 = convert{qt0 -> qt1}(base0)
                price0 = VelodromeUtils.amount1(BASE0, BASE0, QUOTE_BASE, qr0, qr1, IS_QUOTE_POOL_STABLE);
                // price1 = convert{qt0 -> qt1}( convert{t1 -> t0}(base1) )
                price1 = VelodromeUtils.amount0(BASE1, BASE0, BASE1, r0, r1, IS_BASE_POOL_STABLE);
                price1 = VelodromeUtils.amount1(price1, BASE0, QUOTE_BASE, qr0, qr1, IS_QUOTE_POOL_STABLE);
            } else {
                // t0 == qt1 - convertible token, qt0 - quote token
                // price0 = convert{qt1 -> qt0}(base0)
                price0 = VelodromeUtils.amount0(BASE1, QUOTE_BASE, BASE0, qr0, qr1, IS_QUOTE_POOL_STABLE);
                // price1 = convert{qt1 -> qt0}( convert{t1 -> t0}(base1) )
                price1 = VelodromeUtils.amount0(BASE1, BASE0, BASE1, r0, r1, IS_BASE_POOL_STABLE);
                price1 = VelodromeUtils.amount0(price1, QUOTE_BASE, BASE0, qr0, qr1, IS_QUOTE_POOL_STABLE);
            }
        }

        _value0 = _amount0 * price0 * QUOTE_PRICE_FACTOR / BASE0;
        _value1 = _amount1 * price1 * QUOTE_PRICE_FACTOR / BASE1;
    }

}
