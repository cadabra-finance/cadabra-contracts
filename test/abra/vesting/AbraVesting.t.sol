// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import "../../../src/token/AbraVesting.sol";
import "../../../src/token/AbraStaking.sol";

import "../../mocks/AbraMock.sol";
import "../../mocks/RewardsSourceMock.sol";

contract AbraVestingTest is Test {
    
    address immutable ADMIN = makeAddr("admin");
    uint constant REWARD_PER_CALL = 500;

    AbraMock public ABRA;
    AbraStaking public ABRA_STAKING;
    RewardsSourceMock public REWARDS_SOURCE;

    function setUp() public {
        ABRA = new AbraMock();

        REWARDS_SOURCE = new RewardsSourceMock(REWARD_PER_CALL, address(ABRA));
        ABRA.transfer(address(REWARDS_SOURCE), 1e20);

        ABRA_STAKING = new AbraStaking(address(ABRA), block.timestamp, 1 minutes, 1461 days, address(REWARDS_SOURCE));
    }

    function test_paramsNoDust() external {
        AbraVesting vesting = _initializeVesting(
            1000,
            2 minutes,
            1 minutes,
            5
        );

        assertFalse(vesting.$isVestingStarted(), "isVestingStarted");
        assertEq(0, vesting.$actualLockupId(), "actualLockupId");
        assertEq(2 minutes, vesting.$cooldownDuration(), "cooldownDuration");
        assertEq(1 minutes, vesting.$lockPeriodDuration(), "lockPeriodDuration");
        assertEq(5, vesting.$lockPeriodCount(), "lockPeriodCount");
        assertEq(200, vesting.$lockedPerPeriod(), "lockedPerPeriod");
        assertEq(1000, vesting.$totalLocked(), "totalLocked");
    }

    function test_paramsWithDust() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );

        assertFalse(vesting.$isVestingStarted(), "isVestingStarted");
        assertEq(0, vesting.$actualLockupId(), "actualLockupId");
        assertEq(2 minutes, vesting.$cooldownDuration(), "cooldownDuration");
        assertEq(1 minutes, vesting.$lockPeriodDuration(), "lockPeriodDuration");
        assertEq(5, vesting.$lockPeriodCount(), "lockPeriodCount");
        assertEq(200, vesting.$lockedPerPeriod(), "lockedPerPeriod");
        assertEq(1000, vesting.$totalLocked(), "totalLocked");
    }

    function test_startVesting() external {
        uint32 _coolDown = 2 minutes;
        uint32 _lockDuration = 1 minutes;
        uint _lockCount = 5;
        AbraVesting vesting = _initializeVesting(
            1004,
            _coolDown,
            _lockDuration,
            _lockCount
        );
        vesting.startVesting();

        assertTrue(vesting.$isVestingStarted(), "isVestingStarted");
        assertEq(0, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(REWARD_PER_CALL * (_lockCount - 1), ABRA.balanceOf(address(vesting)), 1, "vestingBalance");
        assertEq(0, vesting.earned(address(this)), "earned");
        assertApproxEqAbs(REWARD_PER_CALL * (_lockCount - 1), vesting.$claimable(), 1, "claimable");

        for (uint i = 0; i < _lockCount; i++) {
            (uint128 _amount, uint128 _end, ) = ABRA_STAKING.lockups(address(vesting), i);
            assertEq(200, _amount, "amount");
            assertEq(block.timestamp + _coolDown + _lockDuration * (i + 1), _end, "end");
        }
    }

    function test_notUnlockedBeforeFirstEnd() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        skip(3 minutes - 1);

        uint _claimableBefore = vesting.$claimable();
        uint _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.unlockTokens();
        uint _balanceAfter = ABRA.balanceOf(address(vesting));
        uint _claimableAfter = vesting.$claimable();

        assertEq(0, vesting.$actualLockupId(), "actualLockupId");
        assertEq(0, _balanceAfter - _balanceBefore, "vestingBalance");
        assertEq(0, vesting.earned(address(this)), "earned");
        assertEq(0, _claimableAfter - _claimableBefore, "claimable");
    }

    function test_oneUserOneUnlock() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        skip(3 minutes);

        uint _claimableBefore = vesting.$claimable();
        uint _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.unlockTokens();
        uint _balanceAfter = ABRA.balanceOf(address(vesting));
        uint _claimableAfter = vesting.$claimable();

        assertEq(1, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(200 + REWARD_PER_CALL, _balanceAfter - _balanceBefore, 1, "vestingBalance");
        assertEq(200, vesting.earned(address(this)), "earned");
        assertApproxEqAbs(REWARD_PER_CALL, _claimableAfter - _claimableBefore, 1, "claimable");
    }

    function test_oneUserTwoUnlocks() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        skip(4 minutes);

        uint _claimableBefore = vesting.$claimable();
        uint _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.unlockTokens();
        uint _balanceAfter = ABRA.balanceOf(address(vesting));
        uint _claimableAfter = vesting.$claimable();

        assertEq(2, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(400 + 2 * REWARD_PER_CALL, _balanceAfter - _balanceBefore, 2, "vestingBalance");
        assertEq(400, vesting.earned(address(this)), "earned");
        assertApproxEqAbs(2 * REWARD_PER_CALL, _claimableAfter - _claimableBefore, 2, "claimable");
    }

    function test_oneUserAllUnlocks() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        skip(20 minutes);

        uint _claimableBefore = vesting.$claimable();
        uint _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.unlockTokens();
        uint _balanceAfter = ABRA.balanceOf(address(vesting));
        uint _claimableAfter = vesting.$claimable();

        assertEq(5, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(1000 + 5 * REWARD_PER_CALL, _balanceAfter - _balanceBefore, 5, "vestingBalance");
        assertEq(1000, vesting.earned(address(this)), "earned");
        assertApproxEqAbs(5 * REWARD_PER_CALL, _claimableAfter - _claimableBefore, 5, "claimable");
    }

    function test_transferSharesWhenLockedAndUnlock() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();
        skip(4 minutes);

        uint _claimableBefore = vesting.$claimable();
        uint _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.transfer(ADMIN, 1e6 / 2);
        uint _balanceAfter = ABRA.balanceOf(address(vesting));
        uint _claimableAfter = vesting.$claimable();

        assertEq(2, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(400 + 2 * REWARD_PER_CALL, _balanceAfter - _balanceBefore, 2, "vestingBalance");
        assertEq(400, vesting.earned(address(this)), "earned");
        assertEq(0, vesting.earned(ADMIN), "earned");
        assertApproxEqAbs(2 * REWARD_PER_CALL, _claimableAfter - _claimableBefore, 5, "claimable");

        skip(1 minutes);

        _claimableBefore = vesting.$claimable();
        _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.unlockTokens();
        _balanceAfter = ABRA.balanceOf(address(vesting));
        _claimableAfter = vesting.$claimable();

        assertEq(3, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(200 + REWARD_PER_CALL, _balanceAfter - _balanceBefore, 1, "vestingBalance");
        assertEq(500, vesting.earned(address(this)), "earned");
        assertEq(100, vesting.earned(ADMIN), "earned");
        assertApproxEqAbs(REWARD_PER_CALL, _claimableAfter - _claimableBefore, 1, "claimable");
    }

    function test_maxUnlocksCount() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        skip(60 minutes);

        uint _claimableBefore = vesting.$claimable();
        uint _balanceBefore = ABRA.balanceOf(address(vesting));
        vesting.unlockTokens(2);
        uint _balanceAfter = ABRA.balanceOf(address(vesting));
        uint _claimableAfter = vesting.$claimable();

        assertEq(2, vesting.$actualLockupId(), "actualLockupId");
        assertApproxEqAbs(400 + 2 * REWARD_PER_CALL, _balanceAfter - _balanceBefore, 2, "vestingBalance");
        assertEq(1000, vesting.earned(address(this)), "earned");
        assertApproxEqAbs(2 * REWARD_PER_CALL, _claimableAfter - _claimableBefore, 2, "claimable");
    }

    function test_claim() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        uint _balanceBefore = ABRA.balanceOf(address(this));
        uint _claimable = vesting.$claimable();
        vesting.claim();
        uint _balanceAfter = ABRA.balanceOf(address(this));

        assertApproxEqAbs(_claimable + REWARD_PER_CALL, _balanceAfter - _balanceBefore, 1, "balance");
        assertApproxEqAbs(_claimable + REWARD_PER_CALL, vesting.$claimed(), 1, "balance");
        assertEq(0, vesting.$claimable(), "claimable");
    }

    function test_getReward() external {
        AbraVesting vesting = _initializeVesting(
            1004,
            2 minutes,
            1 minutes,
            5
        );
        vesting.startVesting();

        skip(4 minutes);

        uint _balanceBefore = ABRA.balanceOf(address(this));
        vesting.getReward();
        uint _balanceAfter = ABRA.balanceOf(address(this));

        assertEq(400, _balanceAfter - _balanceBefore,"balance");
        assertEq(uint(400) * 1e18 / 1e6, vesting.$userRewardPerTokenPaid(address(this)), "userRewardPerTokenPaid");

        assertEq(0, vesting.earned(address(this)), "earned");
    }

    function _initializeVesting(
            uint256 _totalAmount,
            uint32 _cooldownDuration,
            uint32 _lockPeriodDuration,
            uint256 _lockPeriodCount
        ) private returns (AbraVesting) {
        AbraVesting vesting = new AbraVesting();
        vesting.initialize(
            "ABRA Vesting Token", 
            "ABRAv",
            address(ABRA_STAKING),
            _totalAmount,
            _cooldownDuration,
            _lockPeriodDuration,
            _lockPeriodCount
        );
        ABRA.approve(address(vesting), _totalAmount);
        return vesting;
    }

}
