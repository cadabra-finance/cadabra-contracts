import { ethers, upgrades } from "hardhat";

// replace consts with real values
const ABRA_STAKING = "0x90dDf9aFB8c67B2b3383cAa3ADA7f7A7a58Bbd89";
const TOTAL_AMOUN = "10000000000000000000";
const COOLDOWN_DURATION = 60 * 5;
const LOCKPERIOD_DURATION = 60 * 5;
const LOOKPERIOD_COUNT = 12; 

async function main() {
    await init();
    await deployAbraVesting();
}

async function init() {
    const [deployer] = await ethers.getSigners();
    console.log('Deployer address: ', deployer.address)
}

async function deployAbraVesting() {
    const AbraVesting = await ethers.getContractFactory("AbraVesting");
    const initializerArgs = ["ABRA Vesting Token", "ABRAv", ABRA_STAKING, TOTAL_AMOUN, COOLDOWN_DURATION, LOCKPERIOD_DURATION, LOOKPERIOD_COUNT];
    const abraVesting = await upgrades.deployProxy(AbraVesting, initializerArgs, {
        unsafeAllow: ["state-variable-immutable"]
    });
    await abraVesting.deployed();
    console.log("AbraVesting deployed to:", abraVesting.address);
    console.log(`Implementation at: ${await upgrades.erc1967.getImplementationAddress(abraVesting.address)}`);
}

main().catch(e => {
    console.error(e);
    process.exit(1);
});