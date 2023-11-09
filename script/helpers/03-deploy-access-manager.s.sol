// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "openzeppelin/access/manager/AccessManager.sol";

contract DeployAccessManagerScript is Script {

    function setUp() public {}

    function run() public {

        uint256 deployerPK      = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPK);
        console2.log("Deployer address: ", deployerAddress);

        vm.startBroadcast(deployerPK);

        AccessManager accessManager = new AccessManager(deployerAddress);
        console2.log("AccessManager address: ", address(accessManager));

        vm.stopBroadcast();
    }
}
