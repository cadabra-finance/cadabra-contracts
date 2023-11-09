// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

interface IReferralRewardsSource {

    function sendReward(address token, address to, uint amount) external;

}