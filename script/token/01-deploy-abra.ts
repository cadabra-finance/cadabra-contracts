import hre, { ethers, upgrades } from "hardhat";
const LZ_ENDPOINTS = require("../../lib/lze-solidity-examples/constants/layerzeroEndpoints.json")

async function deployAbra() {
    
    const INITIAL_SUPPLY = 10n**18n * 13_333_337n;

    const [deployer] = await ethers.getSigners();
    console.log('Deployer address: ', deployer.address);

    let lzEndpointAddress, lzEndpoint, LZEndpointMock
    if (hre.network.name === "hardhat") {
        LZEndpointMock = await ethers.getContractFactory("LZEndpointMock")
        lzEndpoint = await LZEndpointMock.deploy(1)
        lzEndpointAddress = lzEndpoint.address
    } else {
        lzEndpointAddress = LZ_ENDPOINTS[hre.network.name]
    }

    const Abra = await ethers.getContractFactory("Abra");
    const abra = await upgrades.deployProxy(Abra, [INITIAL_SUPPLY, lzEndpointAddress], {constructorArgs: [], unsafeAllow:["state-variable-immutable"]});
    await abra.deployed();
    console.log("Abra deployed to:", abra.address);
}

deployAbra()
    .catch(e => {
        console.error(e);
        process.exit(1);
    });
