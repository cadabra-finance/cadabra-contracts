// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/adapters/BaseAdapter.sol";
import "../../src/interfaces/IBalancer.sol";

import "forge-std/StdAssertions.sol";

// TODO setup max call amount (by checking method_counter)

contract AdapterMock is BaseAdapter, StdAssertions {

    constructor(address balancer) BaseAdapter(balancer) {}

    // --------------------------------------------------------------------------------------------------------
    
    address public invest_dustReceiver;
    uint public invest_valueBefore;
    uint public invest_valueAfter;
    uint public invest_counter;

    function setup_invest(address dustReceiver_, uint valueBefore_, uint valueAfter_) external {
        invest_dustReceiver = dustReceiver_;
        invest_valueBefore = valueBefore_;
        invest_valueAfter = valueAfter_;
        invest_counter = 0;
    }

    function invest(address dustReceiver)
        external
        override
        onlyBalancer
        returns (uint valueBefore, uint valueAfter)
    {
        assertEq(dustReceiver, invest_dustReceiver, "Invalid dustReceiver in invest");
        invest_counter += 1;
        return (invest_valueBefore, invest_valueAfter);
    }
    
    // --------------------------------------------------------------------------------------------------------

    uint public value_estimatedValue;
    uint public value_lpAmount;

    function setup_value(uint estimatedValue_, uint lpAmount_) external {
        value_estimatedValue = estimatedValue_;
        value_lpAmount = lpAmount_;
    }

    function value()
        public
        view
        override
        returns (uint estimatedValue, uint lpAmount)
    {
        return (value_estimatedValue, value_lpAmount);
    }

    // --------------------------------------------------------------------------------------------------------

    uint public redeem_shares;
    address public redeem_receiver;
    uint public redeem_counter;

    function setup_redeem(uint shares_, address receiver_) external {
        redeem_shares = shares_;
        redeem_receiver = receiver_;
        redeem_counter = 0;
    }

    function redeem(
        uint shares,
        address receiver
    ) external override onlyBalancer returns (
            address[] memory tokens,
            uint[] memory amounts
        ) {
        assertEq(shares, redeem_shares, "Invalid shares in redeem");
        assertEq(receiver, redeem_receiver, "Invalid receiver in redeem");
        redeem_counter += 1;
        return (new address[](0), new uint[](0));
    }

    // --------------------------------------------------------------------------------------------------------

    uint public compound_leqBefore;
    uint public compound_leqAfter;
    bool public compound_called;

    function setup_compound(uint compound_leqBefore_, uint compound_leqAfter_) external {
        compound_leqBefore = compound_leqBefore_;
        compound_leqAfter = compound_leqAfter_;
        compound_called = false;
    }

    // TODO check swaps
    function compound(IBalancer.SwapInfo[] memory swaps) external override onlyBalancer returns (uint leqBefore, uint leqAfter) {
        assertFalse(compound_called, "compound already called");
        compound_called = true;
        return (compound_leqBefore, compound_leqAfter);
    }

    // --------------------------------------------------------------------------------------------------------

    function description() external view override returns (string memory) {
        return string.concat('{"type":"mock","vaultAddress": 0x0"}'); 
    }

    function ratios()
        external
        view
        override
        returns (address[] memory tokens, uint[] memory ratios)
    {}

    function pendingRewards() external override view returns(address[] memory token, uint[] memory amount) {}

    function depositTokens() public override view returns (address[] memory tokens) {}

    function _claimAll() internal virtual override {}

    function _invest() internal virtual override {}

    function _redeem(uint256 lpAmount, address to) internal virtual override returns (address[] memory, uint[] memory) {}
}
