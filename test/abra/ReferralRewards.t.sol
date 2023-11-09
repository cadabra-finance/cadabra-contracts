// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "../mocks/AbraMock.sol";
import "../mocks/ReferralRewardsTestable.sol";

import "forge-std/console.sol";
import "forge-std/Test.sol";

struct ExpectedPersonalReward {
    uint32 duration;
    uint withoutReferrerReward;
    uint withReferrerReward;
}

struct ExpectedReferrerReward {
    uint abraLocked;
    uint reward;
}

contract ReferralRewardsTest is Test {
    IERC20 private abra;
    ReferralRewardsTestable private referralRewards;

    function setUp() external {
        referralRewards = new ReferralRewardsTestable();
        abra = new AbraMock();
        referralRewards.setToken(address(abra));
        abra.transfer(address(referralRewards), 1000000 * 1e18);
    }

    function test_persistedReferrerAddresses() external {
        uint balanceOf1Before = abra.balanceOf(address(1));
        uint balanceOf2Before = abra.balanceOf(address(2));
        uint balanceOfL1Before = abra.balanceOf(referralRewards.$referrerL1());
        uint balanceOfL2Before = abra.balanceOf(referralRewards.$referrerL2());
        referralRewards.handleStake(
            address(this),
            address(1),
            address(2),
            10 * 1e18,
            uint32(block.timestamp + 100 days),
            0
        );
        uint balanceOf1After = abra.balanceOf(address(1));
        uint balanceOf2After = abra.balanceOf(address(2));
        uint balanceOfL1After = abra.balanceOf(referralRewards.$referrerL1());
        uint balanceOfL2After = abra.balanceOf(referralRewards.$referrerL2());
        require(balanceOf1Before == balanceOf1After);
        require(balanceOf2Before == balanceOf2After);
        require(balanceOfL1Before < balanceOfL1After);
        require(balanceOfL2Before < balanceOfL2After);
    }

    function test_rewardsPayed() external {
        require(abra.balanceOf(address(1)) == 0);
        require(abra.balanceOf(referralRewards.$referrerL1()) == 0);
        require(abra.balanceOf(referralRewards.$referrerL2()) == 0);
        uint amount = 10 * 1e18;
        uint32 duration = 100 days;
        uint abraLockedL1 = 10000 * 1e18;
        uint abraLockedL2 = 50000 * 1e18;
        referralRewards.setLocked(referralRewards.$referrerL1(), abraLockedL1);
        referralRewards.setLocked(referralRewards.$referrerL2(), abraLockedL2);
        referralRewards.handleStake(
            address(1),
            referralRewards.$referrerL1(),
            referralRewards.$referrerL2(),
            amount,
            uint32(block.timestamp + duration),
            0
        );
        uint referralReward = referralRewards.getReferralReward(
            amount,
            duration,
            true
        );
        require(abra.balanceOf(address(1)) == referralReward);
        require(
            abra.balanceOf(referralRewards.$referrerL1()) ==
                referralRewards.getReferrerL1Reward(
                    referralReward,
                    abraLockedL1
                )
        );
        require(
            abra.balanceOf(referralRewards.$referrerL2()) ==
                referralRewards.getReferrerL2Reward(
                    referralReward,
                    abraLockedL2
                )
        );
    }

    function test_referrerGivesAdditionalReward() external view {
        uint amount = 1e18;
        uint32 duration = 30 days;
        uint withReferrer = referralRewards.getReferralReward(
            amount,
            duration,
            true
        );
        uint withoutReferrer = referralRewards.getReferralReward(
            amount,
            duration,
            false
        );
        require(withoutReferrer < withReferrer);
    }

    function test_personalRewards1() external view {
        uint amount = 1e18;
        ExpectedPersonalReward[] memory data = new ExpectedPersonalReward[](0);
        data = push(data, ExpectedPersonalReward(0, 0, 0));
        data = push(
            data,
            ExpectedPersonalReward(15 days, 3154401824363998, 3970473864458119)
        );
        data = push(
            data,
            ExpectedPersonalReward(
                30 days,
                12499323629673718,
                14099724488142185
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                124 days,
                66955574712931627,
                72833430182020324
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                182 days,
                106084503178910451,
                113983046733146258
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                291 days,
                186751512829344693,
                197162242592178619
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                365 days,
                243570347957639939,
                254843517138599105
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                506 days,
                289687893959284388,
                303406695092228400
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                730 days,
                333333333333333333,
                350649350649350649
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                1461 days,
                500171174255391989,
                519401688019276600
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                1500 days,
                500171174255391989,
                519401688019276600
            )
        );
        for (uint i = 0; i < data.length; i++) {
            ExpectedPersonalReward memory e = data[i];
            require(
                e.withoutReferrerReward ==
                    referralRewards.getReferralReward(amount, e.duration, false)
            );
            require(
                e.withReferrerReward ==
                    referralRewards.getReferralReward(amount, e.duration, true)
            );
        }
    }

    function test_personalRewards2() external {
        uint amount = 1e18;
        ExpectedPersonalReward[] memory data = new ExpectedPersonalReward[](0);
        data = push(data, ExpectedPersonalReward(0, 0, 0));
        data = push(
            data,
            ExpectedPersonalReward(15 days, 2704991939670482, 3521799666930574)
        );
        data = push(
            data,
            ExpectedPersonalReward(
                30 days,
                10732870771899392,
                12338997727026734
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                124 days,
                57944652653301724,
                63936223169257749
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                182 days,
                92328810726932717,
                100471205220717257
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                291 days,
                164460565955268171,
                175445973881720345
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                365 days,
                216300940438871473,
                228395061728395061
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                506 days,
                269377863560867895,
                283884395931629928
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                730 days,
                333333333333333333,
                350649350649350649
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                1461 days,
                500171174255391989,
                519401688019276600
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                1500 days,
                500171174255391989,
                519401688019276600
            )
        );
        vm.warp(block.timestamp + 14 days);
        for (uint i = 0; i < data.length; i++) {
            ExpectedPersonalReward memory e = data[i];
            require(
                e.withoutReferrerReward ==
                    referralRewards.getReferralReward(amount, e.duration, false)
            );
            require(
                e.withReferrerReward ==
                    referralRewards.getReferralReward(amount, e.duration, true)
            );
        }
    }

    function test_personalRewards3() external {
        uint amount = 1e18;
        ExpectedPersonalReward[] memory data = new ExpectedPersonalReward[](0);
        data = push(data, ExpectedPersonalReward(0, 0, 0));
        data = push(
            data,
            ExpectedPersonalReward(15 days, 2255176655504681, 3072721065209969)
        );
        data = push(
            data,
            ExpectedPersonalReward(30 days, 8960086885691012, 10571970723773380)
        );
        data = push(
            data,
            ExpectedPersonalReward(
                124 days,
                48758293902496880,
                54866907704433919
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                182 days,
                78143153002980249,
                86540867911306872
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                291 days,
                140912613520425086,
                152521647342724543
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                365 days,
                186991869918699186,
                200000000000000000
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                506 days,
                241763263949478582,
                257375381485249237
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                730 days,
                315068493150684931,
                333333333333333333
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                1461 days,
                479337546182046417,
                500171174255391989
            )
        );
        data = push(
            data,
            ExpectedPersonalReward(
                1500 days,
                479337546182046417,
                500171174255391989
            )
        );
        vm.warp(block.timestamp + 28 days);
        for (uint i = 0; i < data.length; i++) {
            ExpectedPersonalReward memory e = data[i];
            require(
                e.withoutReferrerReward ==
                    referralRewards.getReferralReward(amount, e.duration, false)
            );
            require(
                e.withReferrerReward ==
                    referralRewards.getReferralReward(amount, e.duration, true)
            );
        }
    }

    function test_referrerL1Rewards() external view {
        uint referralReward = 1e18;
        ExpectedReferrerReward[] memory data = new ExpectedReferrerReward[](0);
        data = push(data, ExpectedReferrerReward(0, 50000000000000000));
        data = push(
            data,
            ExpectedReferrerReward(1000 * 1e18 - 1, 50000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(1000 * 1e18, 70000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(10000 * 1e18 - 1, 70000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(10000 * 1e18, 100000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(50000 * 1e18 - 1, 100000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(50000 * 1e18, 200000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(100000 * 1e18 - 1, 200000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(100000 * 1e18, 300000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(1000000 * 1e18, 300000000000000000)
        );
        for (uint i = 0; i < data.length; i++) {
            ExpectedReferrerReward memory e = data[i];
            require(
                e.reward ==
                    referralRewards.getReferrerL1Reward(
                        referralReward,
                        e.abraLocked
                    )
            );
        }
    }

    function test_referrerL2Rewards() external view {
        uint referralReward = 1e18;
        ExpectedReferrerReward[] memory data = new ExpectedReferrerReward[](0);
        data = push(data, ExpectedReferrerReward(0, 10000000000000000));
        data = push(
            data,
            ExpectedReferrerReward(1000 * 1e18 - 1, 10000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(1000 * 1e18, 30000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(10000 * 1e18 - 1, 30000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(10000 * 1e18, 50000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(50000 * 1e18 - 1, 50000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(50000 * 1e18, 70000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(100000 * 1e18 - 1, 70000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(100000 * 1e18, 100000000000000000)
        );
        data = push(
            data,
            ExpectedReferrerReward(1000000 * 1e18, 100000000000000000)
        );
        for (uint i = 0; i < data.length; i++) {
            ExpectedReferrerReward memory e = data[i];
            require(
                e.reward ==
                    referralRewards.getReferrerL2Reward(
                        referralReward,
                        e.abraLocked
                    )
            );
        }
    }

    function test_extendLeadsToSameRewardAsSingleLongStake() external {
        uint amount = 1000;
        uint32 iterations = 4;
        uint32 duration = 30 days;
        require(abra.balanceOf(address(1)) == 0);
        require(abra.balanceOf(address(1)) == abra.balanceOf(address(2)));
        referralRewards.handleStake(
            address(1),
            referralRewards.$referrerL1(),
            referralRewards.$referrerL2(),
            amount,
            duration * iterations,
            0
        );
        uint32 end = uint32(block.timestamp);
        uint32 initialEnd;
        for (uint i = 0; i < iterations; i++) {
            end += uint32(duration);
            referralRewards.handleStake(
                address(2),
                referralRewards.$referrerL1(),
                referralRewards.$referrerL2(),
                amount,
                end,
                initialEnd
            );
            initialEnd = end;
        }
        // console.log("single stake reward:" , singleStakeReward, "extended reward:", extendedReward);
        require(abra.balanceOf(address(1)) != 0);
        require(abra.balanceOf(address(1)) == abra.balanceOf(address(2)));
    }

    function ignoretest_printRates() external view {
        uint amount = 1e18;
        for (
            uint32 duration = 1 days;
            duration <= 1461 days;
            duration += 1 days
        ) {
            uint r = referralRewards.getReferralReward(amount, duration, true);
            console.log(
                "day",
                duration / 1 days,
                (r * 10000) / amount,
                (r * 10000 * 365 days) / duration / amount
            );
        }
    }

    function ignoretest_printRewards() external view {
        // vm.warp(block.timestamp + 14 days);
        uint amount = 1e18;
        for (
            uint32 duration = 1 days;
            duration <= 1461 days;
            duration += 1 days
        ) {
            console.log(
                "day",
                duration / 1 days,
                referralRewards.getReferralReward(amount, duration, false),
                referralRewards.getReferralReward(amount, duration, true)
            );
        }
    }

    function ignoretest_printReferrerL1Rewards() external view {
        uint referralReward = 1e18;
        for (
            uint lockedAmount = 0;
            lockedAmount < 110000 * 1e18;
            lockedAmount += 500 * 1e18
        ) {
            uint l1Reward = referralRewards.getReferrerL1Reward(
                referralReward,
                lockedAmount
            );
            console.log(
                lockedAmount / 1e18,
                l1Reward,
                (l1Reward * 10000) / referralReward
            );
        }
    }

    function ignoretest_printReferrerL2Rewards() external view {
        uint referralReward = 1e18;
        for (
            uint lockedAmount = 0;
            lockedAmount < 110000 * 1e18;
            lockedAmount += 500 * 1e18
        ) {
            uint l2Reward = referralRewards.getReferrerL2Reward(
                referralReward,
                lockedAmount
            );
            console.log(
                lockedAmount / 1e18,
                l2Reward,
                (l2Reward * 10000) / referralReward
            );
        }
    }

    function test_rewardConstantlyGrows() external view {
        uint amount = 1e18;
        uint prevReward = 0;
        for (
            uint32 duration = 0 days;
            duration <= 1461 days;
            duration += 15 minutes
        ) {
            uint r = referralRewards.getReferralReward(amount, duration, true);
            require(r >= prevReward, "decreasing reward");
            prevReward = r;
        }
    }

    function push(
        ExpectedPersonalReward[] memory data,
        ExpectedPersonalReward memory item
    ) private pure returns (ExpectedPersonalReward[] memory) {
        ExpectedPersonalReward[] memory result = new ExpectedPersonalReward[](
            data.length + 1
        );
        for (uint i = 0; i < data.length; i++) {
            result[i] = data[i];
        }
        result[result.length - 1] = item;
        return result;
    }

    function push(
        ExpectedReferrerReward[] memory data,
        ExpectedReferrerReward memory item
    ) private pure returns (ExpectedReferrerReward[] memory) {
        ExpectedReferrerReward[] memory result = new ExpectedReferrerReward[](
            data.length + 1
        );
        for (uint i = 0; i < data.length; i++) {
            result[i] = data[i];
        }
        result[result.length - 1] = item;
        return result;
    }
}
