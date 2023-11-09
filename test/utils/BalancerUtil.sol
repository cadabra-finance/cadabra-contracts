// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/BalancerUpgradeable.sol";
import "../mocks/AbraMock.sol";
import "../mocks/SwapExecutorMock.sol";
import "openzeppelin/token/ERC20/ERC20.sol";
import "openzeppelin/access/manager/AccessManager.sol";

library BalancerUtil {
    
    function createNew(string memory name_, string memory symbol_, address feeReceiver_) public returns (BalancerUpgradeable) {
        AccessManager manager = new AccessManager(address(this));
        return createNew(name_, symbol_, feeReceiver_, manager);
    }

    function createNew(string memory name_, string memory symbol_, address feeReceiver_, AccessManager manager) public returns(BalancerUpgradeable) {
        AbraMock abra = new AbraMock();
        SwapExecutorMock se = new SwapExecutorMock(3000, 0xB971eF87ede563556b2ED4b1C0b0019111Dd85d2, address(abra), 1e18 * 1e18);
        abra.transfer(address(se), abra.balanceOf(address(this)));
        uint256 depositFee = 1e6 / 2000;
        BalancerUpgradeable balancer = new BalancerUpgradeable(address(abra), address(se), depositFee);
        balancer.initialize(name_, symbol_, feeReceiver_, address(manager));
        return balancer;
    }

    function grantAllRoles(AccessManager manager, address to) public {
        manager.grantRole(manager.ADMIN_ROLE(), to, 0);
    }

}
