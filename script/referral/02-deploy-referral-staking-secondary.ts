import { ethers, upgrades } from "hardhat";

if (!process.env['ABRA_STAKING']) {
    console.error('ABRA_STAKING is not set in env');
    process.exit(1);
}
if (!process.env['MAIN_LZ_CHAIN_ID']) {
    console.error('MAIN_LZ_CHAIN_ID is not set in env');
    process.exit(1);
}
if (!process.env['LZ_ENDPOINT']) {
    console.error('LZ_ENDPOINT is not set in env');
    process.exit(1);
}

const ABRA_STAKING: string = process.env['ABRA_STAKING'];
const MAIN_LZ_CHAIN_ID: number = parseInt(process.env['MAIN_LZ_CHAIN_ID']);
const LZ_ENDPOINT: string = process.env['LZ_ENDPOINT'];

async function deploy() {
    const [deployer] = await ethers.getSigners();
    console.log(`Deployer address: ${deployer.address}`);

    const ReferralStakingSecondary = await ethers.getContractFactory("ReferralStakingSecondary");
    const referralStakingSecondary = await upgrades.deployProxy(
        ReferralStakingSecondary,
        [LZ_ENDPOINT],
        {
            constructorArgs: [ABRA_STAKING, MAIN_LZ_CHAIN_ID],
            unsafeAllow:["constructor", "state-variable-immutable", "state-variable-assignment"]
        });

    await referralStakingSecondary.deployed();
    const implementationAddress = await upgrades.erc1967.getImplementationAddress(referralStakingSecondary.address);
    console.log(`ReferralStakingSecondary deployed at ${referralStakingSecondary.address}`);
    console.log(`ReferralStakingSecondary implementation at ${implementationAddress}`);
}

deploy()
    .catch(e => {
        console.error(e);
        process.exit(1);
    });