import { ethers, upgrades } from "hardhat";

// replace consts with real values
const ABRA = "0x23E00F1C1cdC0F081F2b14EbE741b9f3BdCFe139";
const STAKING_EPOCH = 1699010000; // 27 of September 2023 GMT
const MIN_STAKING_DURATION = 60; // 30 days
const MAX_STAKING_DURATION = 126230400; // 1461 days

let rewardsSourceAddress: string;
let abraStakingAddress: string;

async function main() {
    await init();
    await deployAbraStaking();
    await deployRewardsSource();
    await upgradeAbraStaking();
}

async function init() {
    const [deployer] = await ethers.getSigners();
    console.log('Deployer address: ', deployer.address)
}

async function deployAbraStaking() {
    const AbraStaking = await ethers.getContractFactory("AbraStaking");
    const constructorArgs = [ABRA, STAKING_EPOCH, MIN_STAKING_DURATION, MAX_STAKING_DURATION, "0x0000000000000000000000000000000000000000"];
    const abraStaking = await upgrades.deployProxy(AbraStaking, [], {
        constructorArgs,
        unsafeAllow: ["constructor", "state-variable-immutable", "state-variable-assignment"]
    });
    await abraStaking.deployed();
    console.log("AbraStaking deployed to:", abraStaking.address);
    abraStakingAddress = abraStaking.address;
}

async function deployRewardsSource() {
    const RewardsSource = await ethers.getContractFactory("RewardsSource");
    const rewardsSource = await RewardsSource.deploy(abraStakingAddress);
    await rewardsSource.deployed();
    console.log("RewardsSource deployed to:", rewardsSource.address);
    rewardsSourceAddress = rewardsSource.address;
}

async function upgradeAbraStaking() {
    const AbraStaking = await ethers.getContractFactory("AbraStaking");
    const constructorArgs = [ABRA, STAKING_EPOCH, MIN_STAKING_DURATION, MAX_STAKING_DURATION, rewardsSourceAddress];
    await upgrades.upgradeProxy(abraStakingAddress, AbraStaking, {
        constructorArgs,
        unsafeAllow: ["constructor", "state-variable-immutable", "state-variable-assignment"]
    });
    console.log("AbraStaking implementation upgraded");
}

main().catch(e => {
    console.error(e);
    process.exit(1);
});