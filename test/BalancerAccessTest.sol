// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "./utils/BalancerUtil.sol";
import "../src/BalancerUpgradeable.sol";
import "./mocks/AdapterMock.sol";

contract BalancerAccessTest is Test {
    
    string BSC_MAINNET_RPC_URL = vm.envString("BSC_MAINNET_RPC_URL");

    address immutable admin2 = makeAddr("Admin2");
    address immutable feeReceiver = makeAddr("FeeReceiver");
    address immutable u1 = makeAddr("User1");
    address immutable u2 = makeAddr("User2");
    address immutable u3 = makeAddr("User3");
    AdapterMock adapter1;
    AdapterMock adapter2;

    BalancerUpgradeable balancer;

    function setUp() public {
        vm.createSelectFork(BSC_MAINNET_RPC_URL);
        balancer = BalancerUtil.createNew("BalancerAccessTest", "BST", feeReceiver);

        adapter1 = new AdapterMock(address(balancer));
        adapter2 = new AdapterMock(address(balancer));
    }

    function test_GrantRoleAsAdmin() external {
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
    } 

    function testFail_GrantRoleAsUser() external {
        vm.startPrank(u1);
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u2);
        vm.stopPrank();
    }

    function test_RevokeRoleAsAdmin() external {
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
        balancer.revokeRole(balancer.ADD_ADAPTER_ROLE(), u1);
    } 
        
    function test_RenounceRole() external {
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.startPrank(u1);
        balancer.renounceRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.stopPrank();
    }

    function testFail_RevokeRoleAsUser() external {
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.startPrank(u2);
        balancer.revokeRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.stopPrank();
    }  

    function test_SetSecondAdminAsAdmin() external {
        balancer.grantRole(balancer.DEFAULT_ADMIN_ROLE(), admin2);
    }

    function testFail_SetSecondAdminAsUser() external {
        vm.startPrank(u1);
        balancer.grantRole(balancer.DEFAULT_ADMIN_ROLE(), admin2);
        vm.stopPrank();
    }

    function test_GrantRoleAsSecondAdmin() external {
        balancer.grantRole(balancer.TIMELOCK_ADMIN_ROLE(), admin2);
        vm.startPrank(admin2);
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.stopPrank();
    }

    function test_SecondAdminRenounceRole() external {
        balancer.grantRole(balancer.DEFAULT_ADMIN_ROLE(), admin2);
        vm.startPrank(admin2);
        balancer.renounceRole(balancer.DEFAULT_ADMIN_ROLE(), admin2);
        vm.stopPrank();
    }

    function testFail_GrantRoleAsRenouncedAdmin() external {
        balancer.grantRole(balancer.TIMELOCK_ADMIN_ROLE(), admin2);
        vm.startPrank(admin2);
        balancer.renounceRole(balancer.TIMELOCK_ADMIN_ROLE(), admin2);
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.stopPrank();
    }

    function test_SecondAdminRevokeAdmin() external {
        balancer.grantRole(balancer.DEFAULT_ADMIN_ROLE(), admin2);
        vm.startPrank(admin2);
        balancer.revokeRole(balancer.DEFAULT_ADMIN_ROLE(), address(this));
        vm.stopPrank();
    }

    function testFail_GrantRoleAsRevokedAdmin() external {
        balancer.grantRole(balancer.TIMELOCK_ADMIN_ROLE(), admin2);
        vm.startPrank(admin2);
        balancer.revokeRole(balancer.TIMELOCK_ADMIN_ROLE(), address(this));
        vm.stopPrank();
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
    }

    function test_AddAdapter() external {
        // successful with role
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), u1);
        vm.startPrank(u1);
        balancer.addAdapter(address(adapter1));
        vm.stopPrank();

        // fails without role
        vm.startPrank(u2);
        vm.expectRevert(roleError(u2, balancer.ADD_ADAPTER_ROLE()));
        balancer.addAdapter(address(adapter2));
        vm.stopPrank();
    }

    function test_RemoveAdapter() external {
        // successful with role
        balancer.grantRole(balancer.REMOVE_ADAPTER_ROLE(), u1);
        vm.startPrank(u1);
        balancer.removeAdapter(address(adapter1));
        vm.stopPrank();

        // fails without role
        vm.startPrank(u2);
        vm.expectRevert(roleError(u2, balancer.REMOVE_ADAPTER_ROLE()));
        balancer.removeAdapter(address(adapter2));
        vm.stopPrank();
    }

    function roleError(address account, bytes32 role) internal pure returns (bytes memory) {
        return bytes(
                    abi.encodePacked(
                        "AccessControl: account ",
                        StringsUpgradeable.toHexString(account),
                        " is missing role ",
                        StringsUpgradeable.toHexString(uint256(role), 32)
                    )
                );
    }

}
