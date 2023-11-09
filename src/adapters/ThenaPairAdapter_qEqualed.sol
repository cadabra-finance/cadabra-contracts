// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./ThenaPairAdapter.sol";
import "../interfaces/thena/IPair.sol";
import "../interfaces/thena/IGaugeV2.sol";

contract ThenaPairAdapter_qEqualed is ThenaPairAdapter {

    uint public constant PRICE_DECIMALS    = 18;
    uint public constant PRICE_BASE        = 1e18;

    bool public immutable IS_TOKEN1_QUOTE;
    uint public immutable PRICE_BASE0;
    uint public immutable PRICE_BASE1;
    uint private immutable PRICE_FACTOR0;
    uint private immutable PRICE_FACTOR1;

    constructor(
        address _balancer,
        address _gauge,
        address _quoteToken,
        string memory _description
    ) ThenaPairAdapter(_balancer, _gauge, _description) {
        IS_TOKEN1_QUOTE = _isToken1Quote(_quoteToken);

        uint8 decimals0 = IERC20Metadata(address(TOKEN0)).decimals();
        uint8 decimals1 = IERC20Metadata(address(TOKEN1)).decimals();
        if (decimals0 > PRICE_DECIMALS) revert UnsupportedToken({ token: address(TOKEN0) });
        if (decimals1 > PRICE_DECIMALS) revert UnsupportedToken({ token: address(TOKEN1) });

        PRICE_BASE0 = 10**decimals0;
        PRICE_BASE1 = 10**decimals1;
        PRICE_FACTOR0 = PRICE_BASE / PRICE_BASE0;
        PRICE_FACTOR1 = PRICE_BASE / PRICE_BASE1;
    }

    function _isToken1Quote(address _quoteToken) private view returns (bool _result) {
        if (address(TOKEN0) == _quoteToken) {
            return false;
        } else if (address(TOKEN1) == _quoteToken) {
            return true;
        } else {
            revert UnsupportedToken({ token: _quoteToken });
        }
    }

    function _values(uint256 _amount0, uint256 _amount1) internal view override returns (uint256 _value0, uint256 _value1) {
        if (IS_TOKEN1_QUOTE) {
            uint basePrice = PAIR.current(address(TOKEN0), PRICE_BASE0) * PRICE_FACTOR1;
            _value0 = _amount0 * basePrice / PRICE_BASE0;
            _value1 = _amount1;
        } else {
            uint basePrice = PAIR.current(address(TOKEN1), PRICE_BASE1) * PRICE_FACTOR0;
            _value0 = _amount0;
            _value1 = _amount1 * basePrice / PRICE_BASE1;
        }
    }

}
