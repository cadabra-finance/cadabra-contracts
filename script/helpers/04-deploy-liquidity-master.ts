import { ethers, upgrades } from "hardhat";
import dotenv from "dotenv";
import path from "path";

const env = dotenv.config({path: path.resolve(__dirname, '.env')});

const { ABRA } = env.parsed || process.env || {};
if (!ABRA) {
    console.error('No ABRA env variable');
    process.exit(1);
}

const { POSITION_MANAGER } = env.parsed || process.env || {};
if (!POSITION_MANAGER) {
    console.error('No POSITION_MANAGER env variable');
    process.exit(1);
}

async function main() {

    const [deployer] = await ethers.getSigners();
    console.log('Deployer address: ', deployer.address)

    const LiquidityMasterContract = await ethers.getContractFactory("LiquidityMaster");
    const liquidityMasterInstance = await upgrades.deployProxy(
        LiquidityMasterContract,
        {
            constructorArgs: [POSITION_MANAGER, ABRA],
            unsafeAllow:["constructor", "state-variable-immutable", "state-variable-assignment"]
        }
    );
    await liquidityMasterInstance.deployed();
    console.log("LiquidityMaster deployed to:", liquidityMasterInstance.address);
    console.log(`Implementation at: ${await upgrades.erc1967.getImplementationAddress(liquidityMasterInstance.address)}`);
}

main().catch(e => {
    console.error(e);
    process.exit(1);
});