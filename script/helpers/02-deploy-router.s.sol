// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "../../src/Router.sol";

contract DeployRouterScript is Script {

    // replace with real values
    address immutable private WETH = vm.envAddress("WETH");
    address immutable private SWAP_EXECUTOR = vm.envAddress("SWAP_EXECUTOR");

    function setUp() public {}

    function run() public {

        uint256 deployerPK      = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPK);
        console2.log("Deployer address: ", deployerAddress);

        vm.startBroadcast(deployerPK);

        Router router = new Router(WETH, SWAP_EXECUTOR);
        console2.log("Router address: ", address(router));

        vm.stopBroadcast();
    }
}
