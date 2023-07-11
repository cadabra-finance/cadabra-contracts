// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "./utils/BalancerUtil.sol";
import "./mocks/AdapterMock.sol";
import "../src/BalancerUpgradeable.sol";

contract BalancerAdaptersTest is Test {
    
    string BSC_MAINNET_RPC_URL = vm.envString("BSC_MAINNET_RPC_URL");

    address immutable feeReceiver = makeAddr("FeeReceiver");

    BalancerUpgradeable balancer;
    AdapterMock adapter1;
    AdapterMock adapter2;
    AdapterMock adapter3;

    function setUp() public {
        vm.createSelectFork(BSC_MAINNET_RPC_URL);
        balancer = BalancerUtil.createNew("BalancerAdaptersTest", "BST", feeReceiver);
        BalancerUtil.grantAllRoles(balancer, address(this));

        adapter1 = new AdapterMock(address(balancer));
        adapter2 = new AdapterMock(address(balancer));
        adapter3 = new AdapterMock(address(balancer));
    }

    function test_AddAdapters() external {
        checkState(new address[](0), new address[](0), new address[](0));
    
        {
            addAdapter(adapter1);
            address[] memory expected = new address[](1);
            expected[0] = address(adapter1);
            checkState(expected, new address[](0), expected);
        }

        {
            addAdapter(adapter2);
            address[] memory expected = new address[](2);
            expected[0] = address(adapter1);
            expected[1] = address(adapter2);
            checkState(expected, new address[](0), expected);
        }

        {
            addAdapter(adapter3);
            address[] memory expected = new address[](3);
            expected[0] = address(adapter1);
            expected[1] = address(adapter2);
            expected[2] = address(adapter3);
            checkState(expected, new address[](0), expected);
        }
    } 

    function test_ActivateAddedAdapters() external {
        addAdapter(adapter1);
        addAdapter(adapter2);
        addAdapter(adapter3);

        address[] memory all = new address[](3);
        all[0] = address(adapter1);
        all[1] = address(adapter2);
        all[2] = address(adapter3);

        {
            activateAdapter(adapter1);
            address[] memory active = new address[](1);
            active[0] = address(adapter1);
            address[] memory notActive = new address[](2);
            notActive[0] = address(adapter2);
            notActive[1] = address(adapter3);
            checkState(all, active, notActive);
        }

        {
            activateAdapter(adapter2);
            address[] memory active = new address[](2);
            active[0] = address(adapter1);
            active[1] = address(adapter2);
            address[] memory notActive = new address[](1);
            notActive[0] = address(adapter3);
            checkState(all, active, notActive);
        }

        {
            activateAdapter(adapter3);
            address[] memory active = new address[](3);
            active[0] = address(adapter1);
            active[1] = address(adapter2);
            active[2] = address(adapter3);
            address[] memory notActive = new address[](0);
            checkState(all, active, notActive);
        }
    }

    function test_ActivateNotAllowedAdapter() external {
        addAdapter(adapter1);

        assertFalse(balancer.activateAdapter(address(adapter2)), "not allowed adapter activated");
        
        address[] memory expected = new address[](1);
        expected[0] = address(adapter1);
        checkState(expected, new address[](0), expected);
    }


    function test_RemoveAdapters() external {
        addAdapter(adapter1);
        addAdapter(adapter2);
        addAdapter(adapter3);

        {
            removeAdapter(adapter2);
            address[] memory expected = new address[](2);
            expected[0] = address(adapter1);
            expected[1] = address(adapter3);
            checkState(expected, new address[](0), expected);
        }

        {
            removeAdapter(adapter1);
            address[] memory expected = new address[](1);
            expected[0] = address(adapter3);
            checkState(expected, new address[](0), expected);
        }

        {
            removeAdapter(adapter3);
            address[] memory expected = new address[](0);
            checkState(expected, new address[](0), expected);
        }

    }

    function test_RemoveActiveAdapter() external {
        addAdapter(adapter1);
        addAdapter(adapter2);
        addAdapter(adapter3);
        activateAdapter(adapter1);
        activateAdapter(adapter3);

        removeAdapter(adapter1);

        address[] memory all = new address[](2);
        all[0] = address(adapter3);
        all[1] = address(adapter2);

        address[] memory active = new address[](1);
        active[0] = address(adapter3);
        address[] memory notActive = new address[](1);
        notActive[0] = address(adapter2);
        checkState(all, active, notActive);

        assertFalse(balancer.$isActiveAdapter(address(adapter1)), "Adapter is active");
    }

    function test_RemoveNotAllowedAdapter() external {
        addAdapter(adapter1);
        addAdapter(adapter2);

        assertFalse(balancer.removeAdapter(address(adapter3)), "not allowed adapter removed");

        address[] memory expected = new address[](2);
        expected[0] = address(adapter1);
        expected[1] = address(adapter2);
        checkState(expected, new address[](0), expected);
    }

    function test_RemoveChargedAdapter() external {
        addAdapter(adapter1);
        addAdapter(adapter2);
        address[] memory expected = new address[](2);
        expected[0] = address(adapter1);
        expected[1] = address(adapter2);

        adapter1.setup_value(0, 1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.AdapterNotEmpty.selector, address(adapter1)));
        balancer.removeAdapter(address(adapter1));
        checkState(expected, new address[](0), expected);

        adapter1.setup_value(1, 0);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.AdapterNotEmpty.selector, address(adapter1)));
        balancer.removeAdapter(address(adapter1));
        checkState(expected, new address[](0), expected);

        adapter2.setup_value(1, 1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.AdapterNotEmpty.selector, address(adapter2)));
        balancer.removeAdapter(address(adapter2));
        checkState(expected, new address[](0), expected);
    }

    function test_AddChargedAdapter() external {
        adapter1.setup_value(0, 1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.AdapterNotEmpty.selector, address(adapter1)));
        balancer.addAdapter(address(adapter1));
        checkState(new address[](0), new address[](0), new address[](0));

        adapter1.setup_value(1, 0);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.AdapterNotEmpty.selector, address(adapter1)));
        balancer.addAdapter(address(adapter1));
        checkState(new address[](0), new address[](0), new address[](0));

        adapter1.setup_value(1, 1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.AdapterNotEmpty.selector, address(adapter1)));
        balancer.addAdapter(address(adapter1));
        checkState(new address[](0), new address[](0), new address[](0));
    }

    function test_DeactivateActiveAdapter() external {
        addAdapter(adapter1);
        addAdapter(adapter2);
        addAdapter(adapter3);
        activateAdapter(adapter1);
        activateAdapter(adapter2);
        address[] memory all = new address[](3);
        all[0] = address(adapter1);
        all[1] = address(adapter2);
        all[2] = address(adapter3);

        {
            balancer.deactivateAdapter(address(adapter2));
            address[] memory active = new address[](1);
            active[0] = address(adapter1);
            address[] memory notActive = new address[](2);
            notActive[0] = address(adapter2);
            notActive[1] = address(adapter3);
            checkState(all, active, notActive);
        }

        {
            balancer.deactivateAdapter(address(adapter1));
            checkState(all, new address[](0), all);
        }
    }

    function test_DeactivateNotActiveAdapter() external {
        addAdapter(adapter1);
        addAdapter(adapter2);
        activateAdapter(adapter1);

        balancer.deactivateAdapter(address(adapter2));

        address[] memory all = new address[](2);
        all[0] = address(adapter1);
        all[1] = address(adapter2);
        address[] memory active = new address[](1);
        active[0] = address(adapter1);
        address[] memory notActive = new address[](1);
        notActive[0] = address(adapter2);
        checkState(all, active, notActive);
    }

    function checkState(address[] memory adapters, address[] memory activeAdapters, address[] memory notActiveAdapters) internal {
        assertEq(adapters, balancer.adapters(), "Balancer allowed adapters");

        assertEq(adapters.length, activeAdapters.length + notActiveAdapters.length, "Test error, not all adapters checked");

        for (uint i = 0; i < activeAdapters.length; i++) {
            assertTrue(balancer.$isActiveAdapter(activeAdapters[i]), "Adapter is not active");
         }

        for (uint i = 0; i < notActiveAdapters.length; i++) {
            assertFalse(balancer.$isActiveAdapter(notActiveAdapters[i]), "Adapter is active");
         }
    }

    function addAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.addAdapter(address(adapter_)), "addAdapter failed");
    }

    function removeAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.removeAdapter(address(adapter_)), "removeAdapter failed");
    }

    function activateAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.activateAdapter(address(adapter_)), "activateAdapter failed");
    }

    function deactivateAdapter(AdapterMock adapter_) internal {
        balancer.deactivateAdapter(address(adapter_));
    }

}
