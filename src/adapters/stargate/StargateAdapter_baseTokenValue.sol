// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./AbstractStargateAdapter.sol";

contract StargateAdapter_baseTokenValue is AbstractStargateAdapter {

    constructor(
        address _balancer, 
        address _lpstaking,
        uint _poolId
    ) AbstractStargateAdapter(_balancer, _lpstaking, _poolId) {
    }

    function _baseValue(uint _baseAmount) internal view override returns (uint) {
        return _baseAmount;
    }

}