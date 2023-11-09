// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.20;
import {Initializable} from "openzeppelin-upgradeable/proxy/utils/Initializable.sol";

struct StakeInfo {
    uint16 index;
    uint32 end;
    uint16 prevIndex;
    uint16 nextIndex;
    uint32 nextEnd;
    uint104 amount;
}
struct Track {
    uint16 lowIndex;
    uint32 lowEnd;
    uint16 highIndex;
    uint32 highEnd;
    uint16 activeStakeCount;
    address referrerL1;
    address referrerL2;
    uint104 activeAmount;
}
struct StakerInfo {
    StakeInfo[] stakes;
    Track track;
}

abstract contract StakeTrackerUpgradeable is Initializable {
    /// @custom:storage-location erc7201:cadabra.storage.StakeTracker
    struct StakeTrackerStorage {
        mapping(address => StakerInfo) stakers;
    }
    // keccak256(abi.encode(uint256(keccak256("cadabra.storage.StakeTracker")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant StakeTrackerStorageLocation = 0x74b697a8bc8a2b48669bab455862bc8f75a044a160c494777ae3a854db69d100;

    function _getStakeTrackerStorage() private pure returns (StakeTrackerStorage storage $) {
        assembly {
            $.slot := StakeTrackerStorageLocation
        }
    }

    function __StakeTracker_init() internal onlyInitializing {
    }

    function __StakeTracker_init_unchained() internal onlyInitializing {
    }

    uint public constant CLEANUP_MAX_ITERATIONS = 10;
    event StakeObserved(
        address indexed staker,
        uint16 indexed lzeChainId,
        uint144 amount,
        uint32 end,
        uint16 index
    );

    function stakers(address staker) external view returns(Track memory) {
        StakeTrackerStorage storage $ = _getStakeTrackerStorage();
        return $.stakers[staker].track;
    }

    function stakes(address staker) external view returns (StakeInfo[] memory) {
        StakeTrackerStorage storage $ = _getStakeTrackerStorage();
        return $.stakers[staker].stakes;
    }

    function stakeLength(address staker) external view returns (uint) {
        StakeTrackerStorage storage $ = _getStakeTrackerStorage();
        return $.stakers[staker].stakes.length;
    }

    function activeAmountUpdated(address staker) public returns (uint256) {
        StakeTrackerStorage storage $ = _getStakeTrackerStorage();
        StakerInfo storage stakerInfo = $.stakers[staker];
        StakeInfo[] storage _stakes = stakerInfo.stakes;
        Track memory track = stakerInfo.track;
        uint activeAmountBefore = track.activeAmount;
        _throwOldStakes(track, _stakes);
        if (activeAmountBefore != track.activeAmount) {
            stakerInfo.track = track;
        }
        return track.activeAmount;
    }

    function referrersActiveAmountsUpdated(
        address staker,
        address referrerL1,
        address referrerL2
    ) public returns (address, uint256, address, uint256) {
        StakeTrackerStorage storage $ = _getStakeTrackerStorage();
        StakerInfo storage stakerInfo = $.stakers[staker];
        Track memory track = stakerInfo.track;
        address referrerL1Before = track.referrerL1;
        if (track.referrerL1 == address(0x0)) {
            track.referrerL1 = referrerL1;
            track.referrerL2 = referrerL2;
        }
        uint activeAmountBefore = track.activeAmount;
        StakeInfo[] storage _stakes = stakerInfo.stakes;
        _throwOldStakes(track, _stakes);
        if (
            activeAmountBefore != track.activeAmount ||
            referrerL1Before != track.referrerL1
        ) {
            stakerInfo.track = track;
        }
        uint referrerL1Amount = activeAmountUpdated(track.referrerL1);
        uint referrerL2Amount = activeAmountUpdated(track.referrerL2);
        return (
            track.referrerL1,
            referrerL1Amount,
            track.referrerL2,
            referrerL2Amount
        );
    }

    function _handleStake(
        address staker,
        address referrerL1,
        address referrerL2,
        uint104 amount,
        uint32 end,
        uint16 lzeChainId
    ) internal {
        if (end < block.timestamp) return;
        StakeTrackerStorage storage $ = _getStakeTrackerStorage();
        StakerInfo storage stakerInfo = $.stakers[staker];
        StakeInfo[] storage _stakes = stakerInfo.stakes;
        Track memory track = stakerInfo.track;
        if (track.referrerL1 == address(0x0)) {
            track.referrerL1 = referrerL1;
            track.referrerL2 = referrerL2;
        }

        _throwOldStakes(track, _stakes);

        uint index = _stakes.length;
        require(
            index < type(uint16).max,
            "No more stakes allowed for this address"
        );
        StakeInfo memory last = StakeInfo(uint16(index), end, 0, 0, 0, amount);
        emit StakeObserved(staker, lzeChainId, amount, end, last.index);
        if (track.activeStakeCount == 0) {
            last.prevIndex = last.index;
            last.nextIndex = last.index;
            last.nextEnd = last.end;
            track.lowIndex = last.index;
            track.lowEnd = last.end;
            track.highIndex = last.index;
            track.highEnd = last.end;
        } else if (track.highEnd <= end) {
            StakeInfo storage prev = _stakes[track.highIndex];
            last.prevIndex = prev.index;
            last.nextIndex = last.index;
            last.nextEnd = last.end;
            prev.nextIndex = last.index;
            prev.nextEnd = last.end;
            track.highIndex = last.index;
            track.highEnd = last.end;
        } else if (track.lowEnd >= end) {
            StakeInfo storage next = _stakes[track.lowIndex];
            last.nextIndex = next.index;
            last.nextEnd = next.end;
            last.prevIndex = last.index;
            next.prevIndex = last.index;
            track.lowIndex = last.index;
            track.lowEnd = last.end;
        } else {
            (StakeInfo storage prev, StakeInfo storage next) = _neighbours(
                _stakes,
                track,
                end
            );
            next.prevIndex = last.index;
            last.nextIndex = next.index;
            last.nextEnd = next.end;
            last.prevIndex = prev.index;
            prev.nextIndex = last.index;
            prev.nextEnd = last.end;
        }
        _stakes.push(last);
        track.activeAmount += last.amount;
        track.activeStakeCount++;
        stakerInfo.track = track;
    }

    function _neighbours(
        StakeInfo[] storage _stakes,
        Track memory track,
        uint32 end
    ) private view returns (StakeInfo storage prev, StakeInfo storage next) {
        next = _stakes[track.highIndex];
        prev = _stakes[next.prevIndex];
        while (prev.end > end) {
            next = prev;
            prev = _stakes[next.prevIndex];
        }
    }

    function _throwOldStakes(
        Track memory track,
        StakeInfo[] storage _stakes
    ) private view {
        for (uint iterations = CLEANUP_MAX_ITERATIONS; iterations > 0; iterations--) {
            if (track.activeStakeCount == 0 || track.lowEnd > block.timestamp) return;
            StakeInfo memory _stake = _stakes[track.lowIndex];
            track.activeStakeCount--;
            track.activeAmount -= _stake.amount;
            track.lowIndex = _stake.nextIndex;
            track.lowEnd = _stake.nextEnd;
        }
    }
}
