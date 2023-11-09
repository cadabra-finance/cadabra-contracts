// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/interfaces/IRewardsSource.sol";
import "openzeppelin/token/ERC20/ERC20.sol";

contract RewardsSourceMock is IRewardsSource {

    uint256 public immutable rewardPerCall;
    ERC20 public immutable token;

    constructor (uint _rewardPerCall, address _token) {
        rewardPerCall = _rewardPerCall;
        token = ERC20(_token);
    }

    function previewRewards() external view returns(uint) {
        return rewardPerCall;
    }
    
    function collectRewards() external {
        token.transfer(msg.sender, rewardPerCall);
    }

}
