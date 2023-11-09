pragma solidity ^0.8.19;

interface VenusLens {

    struct PendingReward {
        address vTokenAddress;
        uint256 amount;
    }

    struct RewardSummary {
        address distributorAddress;
        address rewardTokenAddress;
        uint256 totalRewards;
        PendingReward[] pendingRewards;
    }

    function pendingRewards(address holder, address comptroller) external view returns (RewardSummary memory);

}