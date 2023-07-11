// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/adapters/BaseAdapter.sol";
import "../../src/interfaces/IBalancer.sol";

import "forge-std/StdAssertions.sol";
import "openzeppelin/token/ERC20/ERC20.sol";

contract TransferMock is StdAssertions {


    // --------------------------------------------------------------------------------------------------------

    address public transfer_to;
    uint256 public transfer_amount;
    bool public transfer_called;

    function setup_transfer(address to_, uint256 amount_) external {
        transfer_to = to_;
        transfer_amount = amount_;
        transfer_called = false;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        assertFalse(transfer_called, "transfer already called ");
        assertEq(to, transfer_to, "invalid to in transfer");
        assertEq(amount, transfer_amount, "invalid amount in transfer");
        transfer_called = true;
        return true;
    }

    // --------------------------------------------------------------------------------------------------------

}
