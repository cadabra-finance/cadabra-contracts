// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/adapters/BaseAdapter.sol";
import "../../src/interfaces/IBalancer.sol";

import "forge-std/StdAssertions.sol";

contract SwapMock is StdAssertions {

    address public immutable SWAP_EXECUTOR;
    uint256 public immutable VALUE;

    constructor(address _swapExecutor, uint256 _value) {
        SWAP_EXECUTOR = _swapExecutor;
        VALUE = _value;
    }

    function info() public returns (IBalancer.SwapInfo memory) {
        return IBalancer.SwapInfo(
            address(this),
            abi.encodeWithSignature("swap(address,uint256)", address(this), VALUE),
            VALUE,
            address(this)
        );
    }

    // --------------------------------------------------------------------------------------------------------

    bool public transfer_called;
    function transfer(address to, uint256 value) public {
        assertFalse(transfer_called, "transfer already called ");
        
        assertEq(to, SWAP_EXECUTOR, "Invalid to in transfer");
        assertEq(value, VALUE, "Invalid value in transfer");
        
        transfer_called = true;
    }


    bool public approve_called;
    function approve(address spender, uint256 amount) public returns (bool) {
        assertFalse(approve_called, "approve already called");
        assertTrue(transfer_called, "transfer not called");

        assertEq(spender, address(this), "Invalid spender in approve");
        assertEq(amount, VALUE, "Invalid amount in approve");

        approve_called = true;
        return true;
    }

    bool public swap_called;
    function swap(address spender, uint256 amount) public {
        assertFalse(swap_called, "swap already called ");
        assertTrue(approve_called, "approve not called");

        assertEq(spender, address(this), "Invalid spender in swap");
        assertEq(amount, VALUE, "Incorrect amount in swap");

        swap_called = true;
    }

    // --------------------------------------------------------------------------------------------------------

}
