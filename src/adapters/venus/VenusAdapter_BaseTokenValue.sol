// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./AbstractVenusAdapter.sol";

contract VenusAdapter_BaseTokenValue is AbstractVenusAdapter {

    constructor(
        address _balancer,
        address _vToken,
        address _venusLens
    ) AbstractVenusAdapter(_balancer, _vToken, _venusLens) {
        // nothing
    }

    function _value(uint amount) internal view override returns (uint value) {
        return amount;
    }

}