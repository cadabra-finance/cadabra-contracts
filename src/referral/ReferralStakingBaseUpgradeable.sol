// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.20;
import "../interfaces/abra/IAbraStaking.sol";
import "openzeppelin/token/ERC20/IERC20.sol";
import {Initializable} from "openzeppelin-upgradeable/proxy/utils/Initializable.sol";

abstract contract ReferralStakingBaseUpgradeable  is Initializable {
    /// @custom:storage-location erc7201:cadabra.storage.ReferralStakingBase
    struct ReferralStakingBaseStorage {
        mapping(address => mapping(uint => uint32)) handledLockups;
    }
    // keccak256(abi.encode(uint256(keccak256("cadabra.storage.ReferralStakingBase")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant ReferralStakingBaseStorageLocation = 0x411fb405d42b5ea86f656e858b1c5d456d359dca4c32d466ab6a3713d9ce5900;

    function _getReferralStakingBaseStorage() private pure returns (ReferralStakingBaseStorage storage $) {
        assembly {
            $.slot := ReferralStakingBaseStorageLocation
        }
    }

    function __ReferralStakingBase_init() internal onlyInitializing {
    }

    function __ReferralStakingBase_init_unchained() internal onlyInitializing {
    }

    uint16 public constant PT_STAKE = 1;
    struct PayloadStake {
        address staker;
        address referrerL1;
        address referrerL2;
        uint104 amount;
        uint32 end;
        uint32 initialEnd;
    }

    IERC20 internal immutable abra;
    IAbraStaking public immutable abraStaking;
    event LockupHandled(address indexed staker, uint lockupId, uint end);

    constructor(address _abraStaking) {
        abraStaking = IAbraStaking(_abraStaking);
        abra = IERC20(abraStaking.abra());
    }

    function handledLockups(address staker, uint lockupId) external view returns (uint32 end) {
        ReferralStakingBaseStorage storage $ = _getReferralStakingBaseStorage();
        end = $.handledLockups[staker][lockupId];
    }

    function stake(
        uint256 amount,
        uint256 duration,
        address referrerL1,
        address referrerL2,
        bytes memory adapterParams
    ) external {
        _verifyReferralStructure(msg.sender, referrerL1, referrerL2);
        abra.transferFrom(msg.sender, address(this), amount);
        abra.approve(address(abraStaking), amount);
        abraStaking.stake(amount, duration, msg.sender);
        handleLockup(
            abraStaking.lockupsLength(msg.sender) - 1,
            referrerL1,
            referrerL2,
            adapterParams
        );
    }

    function handleLockup(
        uint lockupId,
        address referrerL1,
        address referrerL2,
        bytes memory adapterParams
    ) private {
        (uint128 amount, uint128 end, ) = abraStaking.lockups(msg.sender, lockupId);
        require(amount <= type(uint104).max, "Amount too high");
        ReferralStakingBaseStorage storage $ = _getReferralStakingBaseStorage();
        uint32 prevEnd = $.handledLockups[msg.sender][lockupId];
        if (prevEnd != end) {
            require(prevEnd == 0, "Extend is not supported");
            emit LockupHandled(msg.sender, lockupId, end);
            $.handledLockups[msg.sender][lockupId] = uint32(end);
            PayloadStake memory payload = PayloadStake(
                msg.sender,
                referrerL1,
                referrerL2,
                uint104(amount),
                uint32(end),
                prevEnd
            );
            _afterLockupHandled(payload, adapterParams);
        }
    }

    function _verifyReferralStructure(
        address staker,
        address referrerL1,
        address referrerL2
    ) private pure {
        require(
            staker != address(0) &&
                staker != referrerL1 &&
                staker != referrerL2 &&
                (referrerL1 == address(0) || referrerL1 != referrerL2) &&
                (referrerL2 == address(0) || referrerL1 != address(0)),
            "Invalid referral structure"
        );
    }

    function _afterLockupHandled(
        PayloadStake memory,
        bytes memory adapterParams
    ) internal virtual;
}
