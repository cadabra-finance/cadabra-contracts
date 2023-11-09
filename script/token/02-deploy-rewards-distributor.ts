import { ethers, upgrades } from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log('Deployer address: ', deployer.address)

    // replace with real values
    const ABRA = "0x079eE69bB08f67Ff8df08C878Eb045267F9Aa2A5";

    const INITIALIZER_ARGS: any[] = [];
    const Distributor = await ethers.getContractFactory("RewardsDistributor");
    const distributor = await upgrades.deployProxy(Distributor, INITIALIZER_ARGS, {
        constructorArgs: [ABRA],
        unsafeAllow: ["constructor", "state-variable-immutable"]
    });
    await distributor.deployed();
    console.log("Distributor deployed to:", distributor.address);
}

main().catch(e => {
    console.error(e);
    process.exit(1);
});