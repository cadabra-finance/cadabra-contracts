// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;
import "./ReferralRewards.sol";
import "./ReferralStakingBaseUpgradeable.sol";
import "./StakeTrackerUpgradeable.sol";
import "@layerzerolabs/solidity-examples/contracts-upgradable/lzApp/NonblockingLzAppUpgradeable.sol";
import {UUPSUpgradeable} from "openzeppelin-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract ReferralStakingMain is
    ReferralRewards,
    ReferralStakingBaseUpgradeable,
    StakeTrackerUpgradeable,
    NonblockingLzAppUpgradeable,
    UUPSUpgradeable
{
    uint16 public immutable lzeChainId;
    uint private immutable $epoch;

    constructor(
        address _abraStaking,
        uint16 _lzeChainId
    ) ReferralStakingBaseUpgradeable(_abraStaking) {
        (bool success, bytes memory data) = _abraStaking.staticcall(abi.encodeWithSelector(bytes4(keccak256('epoch()'))));
        require(success && data.length >= 32);
        ($epoch) = abi.decode(data, (uint));
        lzeChainId = _lzeChainId;
    }

    function initialize(address _lzEndpoint) external initializer {
        __LzAppUpgradeable_init(_lzEndpoint);
    }

    function rewardToken() internal view override returns (IERC20) {
        return abra;
    }

    function epoch() internal view virtual override returns (uint) {
        return $epoch;
    }


    function _referrersAbraLockedUpdated(
        address staker,
        address referrerL1,
        address referrerL2
    ) internal virtual override returns (address, uint, address, uint) {
        return
            StakeTrackerUpgradeable.referrersActiveAmountsUpdated(
                staker,
                referrerL1,
                referrerL2
            );
    }

    function _afterLockupHandled(
        PayloadStake memory payload,
        bytes memory
    ) internal virtual override {
        _handleStake(lzeChainId, payload);
    }

    function _nonblockingLzReceive(
        uint16 _srcChainId,
        bytes memory,
        uint64,
        bytes memory _payload
    ) internal override {
        uint16 packetType;
        assembly {
            packetType := mload(add(_payload, 32))
        }
        if (packetType == PT_STAKE) {
            (, PayloadStake memory stake) = abi.decode(
                _payload,
                (uint8, PayloadStake)
            );
            _handleStake(_srcChainId, stake);
        } else {
            revert("ReferralStakingMain: unknown packet type");
        }
    }

    function _handleStake(uint16 chainId, PayloadStake memory stake) private {
        if (stake.end <= block.timestamp) return;
        ReferralRewards._handleStake(
            chainId,
            stake.staker,
            stake.referrerL1,
            stake.referrerL2,
            stake.amount,
            stake.end,
            stake.initialEnd
        );
        StakeTrackerUpgradeable._handleStake(
            stake.staker,
            stake.referrerL1,
            stake.referrerL2,
            stake.amount,
            stake.end,
            chainId
        );
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
