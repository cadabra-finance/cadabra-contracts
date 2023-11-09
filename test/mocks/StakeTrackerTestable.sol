// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "../../src/referral/StakeTrackerUpgradeable.sol";

contract StakeTrackerTestable is StakeTrackerUpgradeable {
    address public constant DEFAULT_REFERRER_L1 = address(1);
    address public constant DEFAULT_REFERRER_L2 = address(2);
    constructor() {}

    function stake(uint104 amount, uint32 end) external {
        stake(amount, end, DEFAULT_REFERRER_L1, DEFAULT_REFERRER_L2);
    }

    function stake(uint104 amount, uint32 end, address referrerL1, address referrerL2) public {
        _handleStake(msg.sender, referrerL1, referrerL2, amount, end, 155);
    }
}
