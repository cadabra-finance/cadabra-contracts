// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "../../src/referral/ReferralRewards.sol";

contract ReferralRewardsTestable is ReferralRewards {
    mapping(address => uint) private locked;
    address public $referrerL1 = address(11);
    address public $referrerL2 = address(12);
    IERC20 private $token;
    uint private $epoch;

    function rewardToken() internal view virtual override returns (IERC20) {
        return $token;
    }

    function epoch() internal view virtual override returns (uint) {
        return $epoch;
    }

    function _referrersAbraLockedUpdated(
        address,
        address,
        address
    ) internal virtual override returns (address, uint, address, uint) {
        return (
            $referrerL1,
            locked[$referrerL1],
            $referrerL2,
            locked[$referrerL2]
        );
    }

    function setLocked(address staker, uint amount) external {
        locked[staker] = amount;
    }

    function setToken(address token) external {
        $token = IERC20(token);
    }

    function handleStake(
        address staker,
        address referrerL1,
        address referrerL2,
        uint amount,
        uint32 end,
        uint32 initialEnd
    ) external {
        _handleStake(56, staker, referrerL1, referrerL2, amount, end, initialEnd);
    }

}