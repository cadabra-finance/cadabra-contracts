// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "../mocks/StakeTrackerTestable.sol";

import "forge-std/console.sol";
import "forge-std/Test.sol";

contract StakeTrackerTest is Test {
    StakeTrackerTestable private tracker;

    function setUp() public {
        tracker = new StakeTrackerTestable();
    }

    function test_firstStake() public {
        uint32 time = _time(1);
        uint104 amount = 144;
        tracker.stake(amount, time);
        Track memory track = tracker.stakers(address(this));
        require(track.lowIndex == 0);
        require(track.lowEnd == time);
        require(track.highIndex == 0);
        require(track.highEnd == time);
        require(track.referrerL1 == tracker.DEFAULT_REFERRER_L1());
        require(track.referrerL2 == tracker.DEFAULT_REFERRER_L2());
        require(track.activeAmount == amount);
        StakeInfo[] memory stakes = tracker.stakes(address(this));
        require(stakes.length == 1);
        require(stakes[0].index == 0);
        require(stakes[0].end == time);
        require(stakes[0].prevIndex == 0);
        require(stakes[0].nextIndex == 0);
        require(stakes[0].nextEnd == time);
        require(stakes[0].amount == amount);
    }

    function test_afterUnstake() public {
        uint32 time = _time(1);
        uint104 amount = 144;
        tracker.stake(amount, time);
        uint activeAmount = tracker.activeAmountUpdated(address(this));
        require(activeAmount == amount);
        vm.warp(time);
        activeAmount = tracker.activeAmountUpdated(address(this));
        require(activeAmount == 0);
        Track memory track = tracker.stakers(address(this));
        require(track.activeAmount == 0);
        require(track.activeStakeCount == 0);
    }

    function test_firstStakeAfterStateReset() public {
        uint32 time = _time(1);
        tracker.stake(143, time);
        vm.warp(time);
        uint104 amount = 154;
        time = _time(0);
        tracker.stake(amount, time);
        Track memory track = tracker.stakers(address(this));
        require(track.lowIndex == 1);
        require(track.lowEnd == time);
        require(track.highIndex == 1);
        require(track.highEnd == time);
        require(track.referrerL1 == tracker.DEFAULT_REFERRER_L1());
        require(track.referrerL2 == tracker.DEFAULT_REFERRER_L2());
        require(track.activeAmount == amount);
    }

    function test_referrersImmutableAfterFirstStake() public {
        tracker.stake(143, _time(1), address(11), address(12));
        tracker.stake(143, _time(1));
        Track memory track = tracker.stakers(address(this));
        require(track.referrerL1 == address(11));
        require(track.referrerL2 == address(12));
    }

    function test_insertFirst() public {
        uint32 time0 = _time(20);
        tracker.stake(120, time0);
        uint32 time1 = _time(10);
        tracker.stake(110, time1);
        Track memory track = tracker.stakers(address(this));
        require(track.lowIndex == 1);
        require(track.lowEnd == time1);
        require(track.highIndex == 0);
        require(track.highEnd == time0);
    }

    function test_insertToTheMiddleGas() public {
        uint count = 1000;
        for (uint i = 0; i < count; i++) {
            tracker.stake(uint104(i + 1), _time(i * 10));
        }
        tracker.stake(1000, _time((count / 2) * 10 - 5));
    }

    function test_complexBehaviour(uint32[] memory times) public {
        for (uint i; i < times.length && i < 50; i++) {
            tracker.stake(times[i], times[i]);
            _verifyState();
        }
        while (true) {
            Track memory track = tracker.stakers(address(this));
            if (track.activeStakeCount == 0) return;
            vm.warp(track.lowEnd);
            tracker.activeAmountUpdated(address(this));
            _verifyState();
        }
    }

    function _verifyState() private view {
        Track memory track = tracker.stakers(address(this));
        StakeInfo[] memory stakes = tracker.stakes(address(this));
        if (track.activeStakeCount == 0) {
            require(track.activeAmount == 0);
            return;
        }
        StakeInfo memory stake = stakes[track.lowIndex];
        uint amount = stake.amount;
        uint16 count = 1;
        while (stake.nextIndex != stake.index) {
            StakeInfo memory next = stakes[stake.nextIndex];
            require(next.index == stake.nextIndex);
            require(next.end == stake.nextEnd);
            require(next.prevIndex == stake.index);
            require(next.end >= stake.end);
            count++;
            amount += next.amount;
            stake = next;
        }
        require(track.activeStakeCount == count);
        require(track.activeAmount == amount);
    }

    function _time(uint secondsAfter) private view returns (uint32) {
        return uint32(block.timestamp + secondsAfter);
    }
}
