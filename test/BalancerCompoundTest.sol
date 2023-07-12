// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "./utils/BalancerUtil.sol";
import "./mocks/AdapterMock.sol";
import "./mocks/TransferMock.sol";
import "./mocks/SwapMock.sol";
import "../src/BalancerUpgradeable.sol";

contract BalancerCompoundTest is Test {
    
    string BSC_MAINNET_RPC_URL = vm.envString("BSC_MAINNET_RPC_URL");

    address immutable feeReceiver = makeAddr("FeeReceiver");
    address immutable user1 = makeAddr("user1");
    address immutable user2 = makeAddr("user2");

    BalancerUpgradeable balancer;
    AdapterMock adapterActive;
    AdapterMock adapterCharged;
    AdapterMock adapterNotActive1;
    AdapterMock adapterNotActive2;
    AdapterMock adapterNotAllowed;

    function setUp() public {
        vm.createSelectFork(BSC_MAINNET_RPC_URL);
        balancer = BalancerUtil.createNew("BalancerAdaptersTest", "BST", feeReceiver);
        BalancerUtil.grantAllRoles(balancer, address(this));

        adapterActive = new AdapterMock(address(balancer));
        adapterCharged = new AdapterMock(address(balancer));
        adapterNotActive1 = new AdapterMock(address(balancer));
        adapterNotActive2 = new AdapterMock(address(balancer));
        adapterNotAllowed = new AdapterMock(address(balancer));

        addAdapter(adapterCharged);
        addAdapter(adapterActive);
        addAdapter(adapterNotActive1);
        addAdapter(adapterNotActive2);

        activateAdapter(adapterCharged);
        activateAdapter(adapterActive);

        {
            adapterCharged.setup_invest(user1, 0, 100);
            vm.startPrank(user1);
            balancer.invest(address(adapterCharged), user1);        
            vm.stopPrank();
        }
    }

    function test_CompoundInvalidAdapter() external {
        vm.expectRevert(abi.encodeWithSelector(IBalancer.InvalidAdapter.selector, address(adapterNotAllowed)));
        compound(adapterNotAllowed, 0);
    }

    function test_CompoundHugePerformanceFee() external {
        uint fee = balancer.MAX_COMPOUND_PERFORMANCE_FEE() + 1;
        vm.expectRevert(abi.encodeWithSelector(IBalancer.InvalidPerformanceFee.selector, fee));
        compound(adapterCharged, fee);
    }

    function test_Compound() external {
        uint fee = balancer.MAX_COMPOUND_PERFORMANCE_FEE();
        adapterCharged.setup_compound(100, 120);
        adapterCharged.setup_value(120, 12);

        compound(adapterCharged, fee);

        assertEq(balancer.$valueReleaseTarget(), 20, "Incorrect $valueReleaseTarget");
        assertEq(balancer.$valueDecayTarget(), 1, "Incorrect $valueDecayTarget");
        assertEq(balancer.$lastValueLock(), block.timestamp, "Incorrect $lastValueLock");
    }

    function compound(AdapterMock adapter, uint performanceFee) internal {
        balancer.compound(address(adapter), performanceFee, new IBalancer.SwapInfo[](0), 0, uint32(block.timestamp));
    }

    function addAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.addAdapter(address(adapter_)), "addAdapter failed");
    }

    function activateAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.activateAdapter(address(adapter_)), "activateAdapter failed");
    }

}
