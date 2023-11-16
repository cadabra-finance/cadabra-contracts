// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;
import "openzeppelin/token/ERC20/IERC20.sol";

struct RewardInfo {
    address staker;
    address referrerL1;
    address referrerL2;
    uint amount;
    uint32 end;
    uint32 initialEnd;
    uint referrerL1Amount;
    uint referrerL2Amount;
    uint referralReward;
    uint referrerL1Reward;
    uint referrerL2Reward;
}

abstract contract ReferralRewards {
    event ReferralReward(
        uint16 indexed lzeChainId,
        address indexed receiver,
        address staker,
        uint256 amount
    );

    function rewardToken() internal view virtual returns (IERC20);

    function epoch() internal view virtual returns (uint);

    function _referrersAbraLockedUpdated(
        address staker,
        address referrerL1,
        address referrerL2
    ) internal virtual returns (address, uint, address, uint);

    function _handleStake(
        uint16 chainId,
        address staker,
        address referrerL1,
        address referrerL2,
        uint amount,
        uint32 end,
        uint32 initialEnd
    ) internal {
        RewardInfo memory info = buildRewardInfo(
            staker,
            referrerL1,
            referrerL2,
            amount,
            end,
            initialEnd
        );
        payRewards(chainId, info);
    }

    function buildRewardInfo(
        address staker,
        address referrerL1,
        address referrerL2,
        uint256 amount,
        uint32 end,
        uint32 initialEnd
    ) private returns (RewardInfo memory) {
        RewardInfo memory info = initRewardInfo(
            staker,
            referrerL1,
            referrerL2,
            amount,
            end,
            initialEnd
        );
        setAbraLocked(info);
        processInitialized(info);
        return info;
    }

    function processInitialized(RewardInfo memory info) private view {
        setRewards(info);

        uint available = rewardToken().balanceOf(address(this));
        if (info.referralReward > available) {
            info.referralReward = available;
        }
        available -= info.referralReward;
        if (info.referrerL1Reward > available) {
            info.referrerL1Reward = available;
        }
        available -= info.referrerL1Reward;
        if (info.referrerL2Reward > available) {
            info.referrerL2Reward = available;
        }
    }

    function initRewardInfo(
        address staker,
        address referrerL1,
        address referrerL2,
        uint amount,
        uint32 end,
        uint32 initialEnd
    ) private pure returns (RewardInfo memory info) {
        info.staker = staker;
        info.referrerL1 = referrerL1;
        info.referrerL2 = referrerL2;
        info.amount = amount;
        info.end = end;
        info.initialEnd = initialEnd;
    }

    function setAbraLocked(RewardInfo memory info) private {
        (
            info.referrerL1,
            info.referrerL1Amount,
            info.referrerL2,
            info.referrerL2Amount
        ) = _referrersAbraLockedUpdated(
            info.staker,
            info.referrerL1,
            info.referrerL2
        );
    }

    function setRewards(RewardInfo memory info) private view {
        setReferralReward(info);
        info.referrerL1Reward = getReferrerL1Reward(
            info.referralReward,
            info.referrerL1Amount
        );
        info.referrerL2Reward = getReferrerL2Reward(
            info.referralReward,
            info.referrerL2Amount
        );
    }

    function setReferralReward(RewardInfo memory info) private view {
        if (info.end <= block.timestamp) return;
        uint duration = info.end - block.timestamp;
        info.referralReward = getReferralReward(
            info.amount,
            duration,
            info.referrerL1 != address(0)
        );
        if (info.initialEnd != 0 && info.initialEnd > block.timestamp) {
            duration = info.initialEnd - block.timestamp;
            info.referralReward -= getReferralReward(
                info.amount,
                duration,
                info.referrerL1 != address(0)
            );
        }
    }

    function getReferralReward(
        uint amount,
        uint duration,
        bool hasReferrer
    ) public view returns (uint reward) {
        if (duration > 1461 days) duration = 1461 days;
        (
            uint start,
            uint stop,
            uint startApr,
            uint stopApr
        ) = getRewardParameters(duration);
        uint apr = startApr;
        if (startApr != stopApr && duration != start) {
            if (startApr <= stopApr) {
                apr +=
                    ((stopApr - startApr) * (duration - start)) /
                    (stop - start);
            } else {
                apr -=
                    ((startApr - stopApr) * (duration - start)) /
                    (stop - start);
            }
        }
        if (hasReferrer) apr += 20000;
        return
            (amount * apr * duration) / (365 days * 1000000 + apr * duration);
    }

    function getRewardParameters(
        uint duration
    )
        private
        view
        returns (uint start, uint stop, uint startApr, uint stopApr)
    {
        if (block.timestamp >= epoch() + 28 days) return getRewardParameters3(duration);
        if (block.timestamp >= epoch() + 14 days) return getRewardParameters2(duration);
        return getRewardParameters1(duration);
    }

    function getRewardParameters1(
        uint duration
    )
        private
        pure
        returns (uint start, uint stop, uint startApr, uint stopApr)
    {
        // example: apr 125% => (100% + 25%) => 25% => 25 * 1kk / 100 => 250000
        if (duration < 30 days) return (0, 30 days, 0, 154000);
        if (duration < 91 days) return (30 days, 91 days, 154000, 196000);
        if (duration < 182 days) return (91 days, 182 days, 196000, 238000);
        if (duration < 365 days) return (182 days, 365 days, 238000, 322000);
        if (duration < 730 days) return (365 days, 730 days, 322000, 230000);
        return (730 days, duration, 230000, 230000);
    }

    function getRewardParameters2(
        uint duration
    )
        private
        pure
        returns (uint start, uint stop, uint startApr, uint stopApr)
    {
        // example: apr 125% => (100% + 25%) => 25% => 25 * 1kk / 100 => 250000
        if (duration < 30 days) return (0, 30 days, 0, 132000);
        if (duration < 91 days) return (30 days, 91 days, 132000, 168000);
        if (duration < 182 days) return (91 days, 182 days, 168000, 204000);
        if (duration < 365 days) return (182 days, 365 days, 204000, 276000);
        if (duration < 730 days) return (365 days, 730 days, 276000, 230000);
        return (730 days, duration, 230000, 230000);
    }

    function getRewardParameters3(
        uint duration
    )
        private
        pure
        returns (uint start, uint stop, uint startApr, uint stopApr)
    {
        // example: apr 125% => (100% + 25%) => 25% => 25 * 1kk / 100 => 250000
        if (duration < 30 days) return (0, 30 days, 0, 110000);
        if (duration < 91 days) return (30 days, 91 days, 110000, 140000);
        if (duration < 182 days) return (91 days, 182 days, 140000, 170000);
        if (duration < 365 days) return (182 days, 365 days, 170000, 230000);
        return (365 days, duration, 230000, 230000);
    }

    function getReferrerL1Reward(
        uint referralReward,
        uint abraLocked
    ) public pure returns (uint reward) {
        if (abraLocked >= 1e23) reward = 30;
        else if (abraLocked >= 5e22) reward = 20;
        else if (abraLocked >= 1e22) reward = 10;
        else if (abraLocked >= 1e21) reward = 7;
        else reward = 5;
        reward = (referralReward * reward) / 100;
    }

    function getReferrerL2Reward(
        uint referralReward,
        uint abraLocked
    ) public pure returns (uint reward) {
        if (abraLocked >= 1e23) reward = 10;
        else if (abraLocked >= 5e22) reward = 7;
        else if (abraLocked >= 1e22) reward = 5;
        else if (abraLocked >= 1e21) reward = 3;
        else reward = 1;
        reward = (referralReward * reward) / 100;
    }

    function payRewards(uint16 chainId, RewardInfo memory info) private {
        payReward(chainId, info.staker, info.staker, info.referralReward);
        payReward(chainId, info.referrerL1, info.staker, info.referrerL1Reward);
        payReward(chainId, info.referrerL2, info.staker, info.referrerL2Reward);
    }

    function payReward(
        uint16 chainId,
        address receiver,
        address staker,
        uint amount
    ) private {
        if (amount > 0 && receiver != address(0)) {
            emit ReferralReward(chainId, receiver, staker, amount);
            rewardToken().transfer(receiver, amount);
        }
    }
}
