// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;
import "./ReferralStakingBaseUpgradeable.sol";
import "@layerzerolabs/solidity-examples/contracts-upgradable/lzApp/NonblockingLzAppUpgradeable.sol";
import {UUPSUpgradeable} from "openzeppelin-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract ReferralStakingSecondary is
    ReferralStakingBaseUpgradeable,
    NonblockingLzAppUpgradeable,
    UUPSUpgradeable
{
    uint16 public immutable mainLzeChainId;
    constructor(
        address _abraStaking,
        uint16 _mainLzeChainId
    ) ReferralStakingBaseUpgradeable(_abraStaking) {
        mainLzeChainId = _mainLzeChainId;
    }

    function initialize(address _lzEndpoint) external initializer {
        __LzAppUpgradeable_init(_lzEndpoint);
    }

    function _afterLockupHandled(PayloadStake memory payload, bytes memory adapterParams) internal virtual override {
        sendMsg(abi.encode(PT_STAKE, payload), adapterParams);
    }

    function _nonblockingLzReceive(
        uint16,
        bytes memory,
        uint64,
        bytes memory
    ) internal pure override {
        revert("ReferralStakingSecondary: unexpected message received");
    }

    function sendMsg(bytes memory payload, bytes memory adapterParams) private {
        _lzSend(
            mainLzeChainId,
            payload,
            payable(msg.sender),
            address(0),
            adapterParams,
            msg.value
        );
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
