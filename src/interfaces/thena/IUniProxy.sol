// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;


interface IUniProxy {

    struct Position {
        uint8 version; // 1->3 proxy 3 transfers, 2-> proxy two transfers, 3-> proxy no transfers
        bool twapOverride; // force twap check for hypervisor instance
        uint32 twapInterval; // override global twap
        uint256 priceThreshold; // custom price threshold
        bool depositOverride; // force custom deposit constraints
        uint256 deposit0Max;
        uint256 deposit1Max;
        uint256 maxTotalSupply;
        bool freeDeposit; // override global freeDepsoit
    }

    function positions(address) external returns (Position memory position);

    function deposit(
        uint256 deposit0,
        uint256 deposit1,
        address to,
        address pos,
        uint256[4] memory minIn
    ) external returns (uint256 shares);

    function getDepositAmount(
        address pos,
        address token,
        uint256 _deposit
    ) external view returns (
        uint256 amountStart,
        uint256 amountEnd
    );
}