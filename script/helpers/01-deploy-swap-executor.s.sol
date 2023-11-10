// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "../../src/helpers/SwapExecutor.sol";

contract DeploySwapExecutorScript is Script {

    uint immutable private UNISWAP_POOL_FEE = vm.envUint("UNISWAP_POOL_FEE");
    address immutable private UNISWAP_ROUTER = vm.envAddress("UNISWAP_ROUTER");
    function setUp() public {}

    function run() public {
        uint256 deployerPK      = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPK);
        console2.log("Deployer address: ", deployerAddress);

        vm.startBroadcast(deployerPK);

        SwapExecutor se = new SwapExecutor(uint24(UNISWAP_POOL_FEE), UNISWAP_ROUTER);
        console2.log("SwapExecutor address: ", address(se));

        vm.stopBroadcast();
    }
}
