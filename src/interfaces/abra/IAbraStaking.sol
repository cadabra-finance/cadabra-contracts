// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

interface IAbraStaking {
    function stake(uint256 amount, uint256 duration, address to) external;

    function lockupsLength(address staker) external view returns (uint);

    function lockups(
        address taker,
        uint lockupId
    ) external view returns (uint128 amount, uint128 end, uint256 points);

    function abra() external view returns (address);
}
