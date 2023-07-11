// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import "./utils/BalancerUtil.sol";
import "./mocks/AdapterMock.sol";
import "../src/BalancerUpgradeable.sol";

contract BalancerInvestTest is Test {
    
    string BSC_MAINNET_RPC_URL = vm.envString("BSC_MAINNET_RPC_URL");

    address immutable feeReceiver = makeAddr("FeeReceiver");
    address immutable user1 = makeAddr("user1");
    address immutable user2 = makeAddr("user2");

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

    function test_InvestNotActiveAdapter() external {
        adapterNotActive1.setup_invest(user1, 0, 10);

        vm.startPrank(user1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.InvalidAdapter.selector, address(adapterNotActive1)));
        balancer.invest(address(adapterNotActive1), address(user1));
        vm.stopPrank();
    }

    function test_InvestNotAllowedAdapter() external {
        adapterNotAllowed.setup_invest(user1, 0, 10);

        vm.startPrank(user1);
        vm.expectRevert(abi.encodeWithSelector(IBalancer.InvalidAdapter.selector, address(adapterNotAllowed)));
        balancer.invest(address(adapterNotAllowed), address(user1));
        vm.stopPrank();
    }

    function test_Invest() external {
        {
            adapterActive1.setup_invest(user1, 0, 10);
            uint valueAdded = 9;

            vm.startPrank(user1);
            invest(user1, adapterActive1, valueAdded);
            vm.stopPrank();

            address[] memory adapters = new address[](1);
            adapters[0] = address(adapterActive1);
            checkState(adapters);
        }
        {
            adapterActive1.setup_value(10, 3);
            adapterNotActive1.setup_value(100000, 1000); // not charged
            adapterActive2.setup_invest(user2, 0, 200);
            uint expectedShares = 179;

            vm.startPrank(user2);
            invest(user2, adapterActive2, expectedShares);
            vm.stopPrank();

            address[] memory adapters = new address[](2);
            adapters[0] = address(adapterActive1);
            adapters[1] = address(adapterActive2);
            checkState(adapters);
        }
        {
            adapterActive1.setup_value(10, 3);
            adapterActive2.setup_value(200, 35);
            adapterNotActive1.setup_value(100000, 1000); // not charged
            adapterActive1.setup_invest(user2, 10, 2000010);
            uint expectedShares = 1789580; // (totalSupply(188) * valueAdded(2000000) / nav(210)) * (10e6 - 2000) / 10e6

            vm.startPrank(user2);
            invest(user2, adapterActive1, expectedShares);
            vm.stopPrank();

            address[] memory adapters = new address[](2);
            adapters[0] = address(adapterActive1);
            adapters[1] = address(adapterActive2);
            checkState(adapters);
        }
    }

    function test_InvestZero() external {
        {
            adapterActive1.setup_invest(user1, 0, 0);

            vm.startPrank(user1);
            vm.expectRevert(abi.encodeWithSelector(IBalancer.SharesInflationError.selector, 0, 0));
            balancer.invest(address(adapterActive1), user1);
            vm.stopPrank();
        }
    }

    function test_InvestZeroWithNotZeroNav() external {
        {
            adapterActive1.setup_invest(user1, 0, 10);
            uint expectedShares = 9;

            vm.startPrank(user1);
            invest(user1, adapterActive1, expectedShares);
            vm.stopPrank();

            address[] memory adapters = new address[](1);
            adapters[0] = address(adapterActive1);
            checkState(adapters);
        }
        {
            adapterActive1.setup_value(10, 3);
            adapterNotActive1.setup_value(100000, 1000); // not charged
            adapterActive1.setup_invest(user2, 10, 10);

            vm.startPrank(user2);
            vm.expectRevert(abi.encodeWithSelector(IBalancer.SharesInflationError.selector, 0, 10));
            balancer.invest(address(adapterActive1), user2);
            vm.stopPrank();
        }
    }

    function invest(address user, IAdapter adapter, uint expectedShares) internal {
        uint balanceBefore = balancer.balanceOf(user);
        assertEq(balancer.invest(address(adapter), user), expectedShares, "incorrect amount of shares returned");
        uint balanceAfter = balancer.balanceOf(user);
        assertEq(balanceAfter - balanceBefore, expectedShares, "incorrect amount of shares minted");
    }

    function checkState(address[] memory chargedAdapters) internal {
        assertEq(chargedAdapters, balancer.chargedAdapters(), "Balancer chargedAdapters");
    }

    function addAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.addAdapter(address(adapter_)), "addAdapter failed");
    }

    function activateAdapter(AdapterMock adapter_) internal {
        assertTrue(balancer.activateAdapter(address(adapter_)), "activateAdapter failed");
    }

}
