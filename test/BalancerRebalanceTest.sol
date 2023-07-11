// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "./utils/BalancerUtil.sol";
import "./mocks/AdapterMock.sol";
import "./mocks/TransferMock.sol";
import "./mocks/SwapMock.sol";
import "../src/BalancerUpgradeable.sol";

 // TODO tests for minRebalancedValue

contract BalancerRebalanceTest is Test {
    
    string BSC_MAINNET_RPC_URL = vm.envString("BSC_MAINNET_RPC_URL");

    address immutable feeReceiver = makeAddr("FeeReceiver");
    address immutable user1 = makeAddr("user1");
    address immutable user2 = makeAddr("user2");
    address swapExecutor;

    BalancerUpgradeable balancer;
    AdapterMock adapterActive1;
    AdapterMock adapterActive2;
    AdapterMock adapterNotActive1;
    AdapterMock adapterNotActive2;
    AdapterMock adapterNotAllowed;

    function setUp() public {
        vm.createSelectFork(BSC_MAINNET_RPC_URL);
        balancer = BalancerUtil.createNew("BalancerAdaptersTest", "BST", feeReceiver);
        BalancerUtil.grantAllRoles(balancer, address(this));
        swapExecutor = address(balancer.SWAP_EXECUTOR());

        adapterActive1 = new AdapterMock(address(balancer));
        adapterActive2 = new AdapterMock(address(balancer));
        adapterNotActive1 = new AdapterMock(address(balancer));
        adapterNotActive2 = new AdapterMock(address(balancer));
        adapterNotAllowed = new AdapterMock(address(balancer));

        addAdapter(adapterActive1);
        addAdapter(adapterActive2);
        addAdapter(adapterNotActive1);
        addAdapter(adapterNotActive2);

        activateAdapter(adapterActive1);
        activateAdapter(adapterActive2);
    }

    function test_RebalanceToNotActiveAdapter() external {
        vm.expectRevert(abi.encodeWithSelector(IBalancer.InvalidAdapter.selector, address(adapterNotActive1)));
        rebalance(adapterActive1, adapterNotActive1, 10);
    }

    function test_RebalanceBeforeCooldown() external {
        rewind(block.timestamp);
        skip(balancer.REBALANCE_COOLDOWN() - 1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.Cooldown.selector, balancer.REBALANCE_COOLDOWN()));
        rebalance(adapterActive1, adapterActive2, 10);
    }

    function test_RebalanceInsufficientFunds() external {
        adapterActive1.setup_value(100000000, 9);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.InsufficientFunds.selector, 9, 10));
        rebalance(adapterActive1, adapterActive2, 10);
    }

    function test_Rebalance() external {
        adapterActive1.setup_value(100, 10);
        adapterActive1.setup_redeem(5, address(balancer));
        adapterActive2.setup_invest(address(balancer), 1000, 1055);

        rebalance(adapterActive1, adapterActive2, 5);

        assertEq(adapterActive1.redeem_counter(), 1, "Redeem should be called");
        assertEq(adapterActive2.invest_counter(), 1, "Invest should be called");
        assertEq(balancer.$lastRebalanceTime(), block.timestamp, "lastRebalanceTime not updated");
    }

    function test_RebalanceWithTransfer() external {
        adapterActive1.setup_value(100, 10);
        adapterActive1.setup_redeem(5, address(balancer));
        adapterActive2.setup_invest(address(balancer), 1000, 1055);

        TransferMock transferMock1 = new TransferMock();
        transferMock1.setup_transfer(address(adapterActive2), 333);
        IBalancer.TransferInfo[] memory transfers = new IBalancer.TransferInfo[](1);
        transfers[0] = IBalancer.TransferInfo(333, address(transferMock1));

        rebalance(adapterActive1, adapterActive2, 5, transfers);

        assertEq(adapterActive1.redeem_counter(), 1, "Redeem should be called");
        assertEq(adapterActive2.invest_counter(), 1, "Invest should be called");
        assertTrue(transferMock1.transfer_called(), "Transfer1 should be called");
        assertEq(balancer.$lastRebalanceTime(), block.timestamp, "lastRebalanceTime not updated");
    }

    function test_RebalanceWithTwoTransfers() external {
        adapterActive1.setup_value(100, 10);
        adapterActive1.setup_redeem(5, address(balancer));
        adapterActive2.setup_invest(address(balancer), 1000, 1055);

        TransferMock transferMock1 = new TransferMock();
        transferMock1.setup_transfer(address(adapterActive2), 333);
        TransferMock transferMock2 = new TransferMock();
        transferMock2.setup_transfer(address(adapterActive2), 222);
        IBalancer.TransferInfo[] memory transfers = new IBalancer.TransferInfo[](2);
        transfers[0] = IBalancer.TransferInfo(333, address(transferMock1));
        transfers[1] = IBalancer.TransferInfo(222, address(transferMock2));

        rebalance(adapterActive1, adapterActive2, 5, transfers);

        assertEq(adapterActive1.redeem_counter(), 1, "Redeem should be called");
        assertEq(adapterActive2.invest_counter(), 1, "Invest should be called");
        assertTrue(transferMock1.transfer_called(), "Transfer1 should be called");
        assertTrue(transferMock2.transfer_called(), "Transfer2 should be called");
        assertEq(balancer.$lastRebalanceTime(), block.timestamp, "lastRebalanceTime not updated");
    }

    function test_RebalanceWithSwap() external {
        adapterActive1.setup_value(100, 10);
        adapterActive1.setup_redeem(5, address(balancer));
        adapterActive2.setup_invest(address(balancer), 1000, 1055);

        SwapMock swapMock1 = new SwapMock(swapExecutor, 444);
        IBalancer.SwapInfo[] memory swaps = new IBalancer.SwapInfo[](1);
        swaps[0] = swapMock1.info();

        rebalance(adapterActive1, adapterActive2, 5, swaps);

        assertEq(adapterActive1.redeem_counter(), 1, "Redeem should be called");
        assertEq(adapterActive2.invest_counter(), 1, "Invest should be called");
        assertTrue(swapMock1.swap_called(), "Swap1 should be called");
        assertEq(balancer.$lastRebalanceTime(), block.timestamp, "lastRebalanceTime not updated");
    }

    function test_RebalanceWithTwoSwap() external {
        adapterActive1.setup_value(100, 10);
        adapterActive1.setup_redeem(5, address(balancer));
        adapterActive2.setup_invest(address(balancer), 1000, 1055);

        SwapMock swapMock1 = new SwapMock(swapExecutor, 444);
        SwapMock swapMock2 = new SwapMock(swapExecutor, 999);
        IBalancer.SwapInfo[] memory swaps = new IBalancer.SwapInfo[](2);
        swaps[0] = swapMock1.info();
        swaps[1] = swapMock2.info();

        rebalance(adapterActive1, adapterActive2, 5, swaps);

        assertEq(adapterActive1.redeem_counter(), 1, "Redeem should be called");
        assertEq(adapterActive2.invest_counter(), 1, "Invest should be called");
        assertTrue(swapMock1.swap_called(), "Swap1 should be called");
        assertTrue(swapMock2.swap_called(), "Swap2 should be called");
        assertEq(balancer.$lastRebalanceTime(), block.timestamp, "lastRebalanceTime not updated");
    }

    function test_RebalanceWithSwapAndTransfer() external {
        adapterActive1.setup_value(100, 10);
        adapterActive1.setup_redeem(5, address(balancer));
        adapterActive2.setup_invest(address(balancer), 1000, 1055);

        SwapMock swapMock1 = new SwapMock(swapExecutor, 444);
        IBalancer.SwapInfo[] memory swaps = new IBalancer.SwapInfo[](1);
        swaps[0] = swapMock1.info();

        TransferMock transferMock1 = new TransferMock();
        transferMock1.setup_transfer(address(adapterActive2), 333);
        IBalancer.TransferInfo[] memory transfers = new IBalancer.TransferInfo[](1);
        transfers[0] = IBalancer.TransferInfo(333, address(transferMock1));

        rebalance(adapterActive1, adapterActive2, 5, swaps, transfers);

        assertEq(adapterActive1.redeem_counter(), 1, "Redeem should be called");
        assertEq(adapterActive2.invest_counter(), 1, "Invest should be called");
        assertTrue(swapMock1.swap_called(), "Swap1 should be called");
        assertTrue(transferMock1.transfer_called(), "Transfer1 should be called");
        assertEq(balancer.$lastRebalanceTime(), block.timestamp, "lastRebalanceTime not updated");
    }

    function rebalance(IAdapter fromAdapter, IAdapter toAdapter, uint amount, IBalancer.SwapInfo[] memory swaps, IBalancer.TransferInfo[] memory transfers) internal {
        balancer.rebalance(fromAdapter, toAdapter, amount, swaps, transfers, 0);
    }

    function rebalance(IAdapter fromAdapter, IAdapter toAdapter, uint amount, IBalancer.SwapInfo[] memory swaps) internal {
        balancer.rebalance(fromAdapter, toAdapter, amount, swaps, new IBalancer.TransferInfo[](0), 0);
    }

    function rebalance(IAdapter fromAdapter, IAdapter toAdapter, uint amount, IBalancer.TransferInfo[] memory transfers) internal {
        balancer.rebalance(fromAdapter, toAdapter, amount, new IBalancer.SwapInfo[](0), transfers, 0);
    }

    function rebalance(IAdapter fromAdapter, IAdapter toAdapter, uint amount) internal {
        balancer.rebalance(fromAdapter, toAdapter, amount, new IBalancer.SwapInfo[](0), new IBalancer.TransferInfo[](0), 0);
    }

    function addAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.addAdapter(address(adapter_)), "addAdapter failed");
    }

    function activateAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.activateAdapter(address(adapter_)), "activateAdapter failed");
    }

}
