import { ethers, upgrades } from "hardhat";

if (!process.env['ABRA_STAKING']) {
    console.error('ABRA_STAKING is not set in env');
    process.exit(1);
}
if (!process.env['LZ_CHAIN_ID']) {
    console.error('LZ_CHAIN_ID is not set in env');
    process.exit(1);
}
if (!process.env['LZ_ENDPOINT']) {
    console.error('LZ_ENDPOINT is not set in env');
    process.exit(1);
}

const ABRA_STAKING: string = process.env['ABRA_STAKING'];
const LZ_CHAIN_ID: number = parseInt(process.env['LZ_CHAIN_ID']);
const LZ_ENDPOINT: string = process.env['LZ_ENDPOINT'];

async function deploy() {
    const [deployer] = await ethers.getSigners();
    console.log(`Deployer address: ${deployer.address}`);

    const ReferralStakingMain = await ethers.getContractFactory("ReferralStakingMain");
    const referralStakingMain = await upgrades.deployProxy(
        ReferralStakingMain,
        [LZ_ENDPOINT],
        {
            constructorArgs: [ABRA_STAKING, LZ_CHAIN_ID],
            unsafeAllow:["constructor", "state-variable-immutable", "state-variable-assignment"]
        });

    await referralStakingMain.deployed();
    const implementationAddress = await upgrades.erc1967.getImplementationAddress(referralStakingMain.address);
    console.log(`ReferralStakingMain deployed at ${referralStakingMain.address}`);
    console.log(`ReferralStakingMain implementation at ${implementationAddress}`);
}

deploy()
    .catch(e => {
        console.error(e);
        process.exit(1);
    });