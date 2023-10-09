// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.8.0 <0.9.0;

import "openzeppelin/token/ERC20/IERC20.sol";
import "openzeppelin-upgradeable/access/Ownable2StepUpgradeable.sol";
import "openzeppelin-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";
import "openzeppelin-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "openzeppelin/token/ERC20/utils/SafeERC20.sol";

import "./AbraStaking.sol";

contract AbraVesting is Ownable2StepUpgradeable, ERC20Upgradeable, UUPSUpgradeable {

    using SafeERC20 for IERC20;

    event Harvest(address indexed user, uint256 reward);
    event Distributed(uint256 reward);
    event Claimed(uint256 amount);

    uint256 public constant TOTAL_SUPPLY = 1e6;

    IERC20 public immutable ABRA;
    AbraStaking public immutable ABRA_STAKING;

    // vesting params
    uint256 public immutable totalLocked;
    uint32 public immutable cooldownDuration;
    uint32 public immutable lockPeriodDuration;
    uint256 public immutable lockPeriodCount;
    uint256 public immutable lockedPerPeriod;
    uint256 public immutable lockedLastPeriod;

    // locking
    bool public isVestingStarted;
    uint256 public actualLockupId;

    // distribution
    uint256 public rewardPerToken;
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    // admin claim
    uint256 public claimable;
    uint256 public claimed;

    constructor(
        address _abraStaking,
        uint256 _totalAmount,
        uint32 _cooldownDuration,
        uint32 _lockPeriodDuration,
        uint256 _lockPeriodCount
    ) {
        ABRA_STAKING = AbraStaking(_abraStaking);
        ABRA = ERC20(ABRA_STAKING.abra());
        uint256 minStakeDuration = ABRA_STAKING.minStakeDuration();
        uint256 maxStakeDuration = ABRA_STAKING.MAX_STAKE_DURATION();

        uint256 vestingMinStakeDuration = _lockPeriodDuration + _cooldownDuration;
        uint256 vestingMaxStakeDuration = _lockPeriodDuration * _lockPeriodCount + _cooldownDuration;

        require(vestingMinStakeDuration >= minStakeDuration && vestingMaxStakeDuration <= maxStakeDuration, "Invalid lock duration");

        totalLocked = _totalAmount;
        cooldownDuration = _cooldownDuration;
        lockPeriodDuration = _lockPeriodDuration;
        lockPeriodCount = _lockPeriodCount;
        lockedPerPeriod = _totalAmount / _lockPeriodCount;
        lockedLastPeriod = lockedPerPeriod + _totalAmount - lockedPerPeriod * _lockPeriodCount;
    }

    function initialize(string memory name_, string memory symbol_) public initializer {
        __ERC20_init(name_, symbol_);
        __Ownable2Step_init();
    }

    //╔═══════════════════════════════════════════ LOCKING ═══════════════════════════════════════════╗

    function startVesting() external onlyOwner {
        require(isVestingStarted == false, "Already vesting");
        isVestingStarted = true;

        uint _totalAmount = totalLocked;
        ABRA.safeTransferFrom(msg.sender, address(this), _totalAmount);
        ABRA.approve(address(ABRA_STAKING), _totalAmount);

        uint _periodCount = lockPeriodCount;
        uint _periodAmount = lockedPerPeriod;
        uint _periodDuration = lockPeriodDuration;
        uint _cooldown = cooldownDuration;
        for (uint i = 1; i <= _periodCount; i++) {
            uint _amount = _periodAmount;
            if (i == _periodCount) {
                _amount = lockedLastPeriod;
            }

            uint _duration = _cooldown + i * _periodDuration;
            ABRA_STAKING.stake(_amount, _duration);
        }

        ABRA_STAKING.delegate(msg.sender);
        _mint(msg.sender, TOTAL_SUPPLY);

        uint _claimed = ABRA.balanceOf(address(this));
        if (_claimed > 0) {
            _considerRewards(_claimed);
        }
    }

    function unlockTokens() public {
        unlockTokens(type(uint256).max);
    }

    function unlockTokens(uint256 maxUnlockItems) public {
        uint _lockCount = lockPeriodCount;
        uint _lockupId = actualLockupId;
        if (_lockupId >= _lockCount) {
            return;
        }

        uint _balanceBefore = ABRA.balanceOf(address(this));
        uint _totalUnlocked = 0;
        for (uint unlockCount; unlockCount < maxUnlockItems && _lockupId < _lockCount; unlockCount++) {
            (uint128 _amount, uint128 _end, ) = ABRA_STAKING.lockups(address(this), _lockupId);
            if (block.timestamp >= _end) {
                ABRA_STAKING.unstake(_lockupId);
                _totalUnlocked += _amount;
                _lockupId += 1;
            } else {
                break;
            }
        }
        actualLockupId = _lockupId;

        uint _balanceAfter = ABRA.balanceOf(address(this));
        uint _claimed = _balanceAfter - _balanceBefore - _totalUnlocked;

        if (_totalUnlocked > 0) {
            _distribute(_totalUnlocked);
        }
        if (_claimed > 0) {
            _considerRewards(_claimed);
        }
    }

    function availableAmountToUnlock() public view returns (uint256 amount) {
        for (uint id = actualLockupId; id < lockPeriodCount; id++) {
            (uint128 _amount, uint128 _end, ) = ABRA_STAKING.lockups(address(this), id);
            if (block.timestamp >= _end) {
                amount += _amount;
            } else {
                break;
            }
        }
    }

    //╔═══════════════════════════════════════════ DISTRIBUTION ═══════════════════════════════════════════╗

    ///@notice see earned rewards for user
    function earned(address account) public view returns (uint256) {
        uint _rewardPerToken = rewardPerToken + availableAmountToUnlock() * 1e18 / TOTAL_SUPPLY;
        return rewards[account] + balanceOf(account) * (_rewardPerToken - userRewardPerTokenPaid[account]) / 1e18;
    }

    ///@notice User harvest function
    function getReward() external {
        unlockTokens();
        uint _reward = earned(msg.sender);
        if (_reward > 0) {
            userRewardPerTokenPaid[msg.sender] = rewardPerToken;
            rewards[msg.sender] = 0;
            emit Harvest(msg.sender, _reward);
            ABRA.safeTransfer(msg.sender, _reward);
        }
    }

    function updateReward(address account) private {
        if (account != address(0)) {
            uint256 _earned = earned(account);
            if (_earned > rewards[account]) {
                rewards[account] = _earned;
            }
            uint256 _rewardPerToken = rewardPerToken;
            if (_rewardPerToken > userRewardPerTokenPaid[account]) {
                userRewardPerTokenPaid[account] = _rewardPerToken;
            }
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        unlockTokens();
        updateReward(from);
        updateReward(to);
    }

    function _distribute(uint reward) private {
        rewardPerToken += reward * 1e18 / TOTAL_SUPPLY;
        emit Distributed(reward);
    }

    //╔═══════════════════════════════════════════ CLAIM ═══════════════════════════════════════════╗

    function claim() external onlyOwner {
        uint _amountToClaim = claimable;

        uint _rewards = ABRA_STAKING.previewRewards(address(this));
        if (_rewards > 0) {
            ABRA_STAKING.collectRewards();
            _amountToClaim += _rewards;
        }

        emit Claimed(_amountToClaim);
        ABRA.safeTransfer(msg.sender, _amountToClaim);

        claimable = 0;
        claimed += _amountToClaim;
    }

    function previewClaim() external view returns (uint) {
        return claimable + ABRA_STAKING.previewRewards(address(this));
    }

    function _considerRewards(uint amount) private {
        claimable += amount;
    }

    //╔═══════════════════════════════════════════ ADMIN ═══════════════════════════════════════════╗

    function _authorizeUpgrade(address) internal override onlyOwner {}

}