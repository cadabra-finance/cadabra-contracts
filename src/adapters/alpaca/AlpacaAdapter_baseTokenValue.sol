// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./AbstractAlpacaAdapter.sol";

contract AlpacaAdapter_baseTokenValue is AbstractAlpacaAdapter {

    constructor(
        address _balancer, 
        address _moneyMarket, 
        address _base
    ) AbstractAlpacaAdapter(_balancer, _moneyMarket, _base) {
    }

    function _baseValue(uint _baseAmount) internal view override returns (uint) {
        return _baseAmount;
    }

}