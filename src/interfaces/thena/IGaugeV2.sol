// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IGaugeV2 {

    ///@notice balance of a user
    function balanceOf(address account) external view returns (uint256);
    
    function rewardToken() external returns(address);

    ///@notice deposit all TOKEN of msg.sender
    function depositAll() external;

    ///@notice deposit amount TOKEN
    function deposit(uint256 amount) external;

    ///@notice withdraw a certain amount of TOKEN
    function withdraw(uint256 amount) external;

    ///@notice withdraw all token
    function withdrawAll() external;
    
    ///@notice withdraw all TOKEN and harvest rewardToken
    function withdrawAllAndHarvest() external;

    ///@notice User harvest function
    function getReward() external;

    ///@notice see earned rewards for user
    function earned(address account) external view returns (uint256);

    function TOKEN() external view returns (address);
    
}
