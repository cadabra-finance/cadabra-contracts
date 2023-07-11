// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../src/BalancerUpgradeable.sol";
import "../../src/helpers/SwapExecutor.sol";

library BalancerUtil {
    
    function createNew(string memory name_, string memory symbol_, address feeReceiver_) public returns(BalancerUpgradeable) {
        SwapExecutor se = new SwapExecutor();
        uint256 depositFee = 1e6 / 2000;
        BalancerUpgradeable balancer = new BalancerUpgradeable(address(se), depositFee);
        balancer.initialize(name_, symbol_, feeReceiver_);
        return balancer;
    }

    function grantAllRoles(BalancerUpgradeable balancer, address to) public {
        balancer.grantRole(balancer.ADD_ADAPTER_ROLE(), to);
        balancer.grantRole(balancer.REMOVE_ADAPTER_ROLE(), to);
        balancer.grantRole(balancer.ACTIVATE_ADAPTER_ROLE(), to);
        balancer.grantRole(balancer.DEACTIVATE_ADAPTER_ROLE(), to);
        balancer.grantRole(balancer.REBALANCE_ROLE(), to);
        balancer.grantRole(balancer.COMPOUND_ROLE(), to);
        balancer.grantRole(balancer.TAKE_PERFORMANCE_FEE_ROLE(), to);
        balancer.grantRole(balancer.UPGRADE_ROLE(), to);
    }

}
