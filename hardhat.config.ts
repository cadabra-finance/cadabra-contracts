import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-toolbox";
// import "@nomicfoundation/hardhat-verify";
import '@openzeppelin/hardhat-upgrades';
import "hardhat-contract-sizer";


import path from "path";
import dotenv from 'dotenv';

const env = dotenv.config({path: path.resolve(__dirname, '.env')});

const {
  PRIVATE_KEY,
  BSCSCAN_MAINNET_KEY,
  POLYGON_MAINNET_KEY,
  OPTIMISM_MAINNET_KEY,
  ETHERESCAN_MAINNET_KEY,
} = env.parsed || process.env || {};


const config: HardhatUserConfig = {
  contractSizer: {
    runOnCompile: true,
    unit: 'B',
  },
  solidity: {
    version: "0.8.20",
    settings: {
      // viaIR: true,
      optimizer: {
        enabled: true,
        runs: 200,
      },    
      evmVersion: "paris"
    }
  },
  networks: {
    bsc: {
      url: `https://bsc-dataseed.binance.org`,
      chainId: 56,
      accounts: [`0x${PRIVATE_KEY}`],
      gasPrice: 3000000000,
      // gas: 1000000,
      loggingEnabled: true,
    },
  },
  etherscan: {
    apiKey: {
      bsc: BSCSCAN_MAINNET_KEY!,
      polygon: POLYGON_MAINNET_KEY!,
      optimisticEthereum: OPTIMISM_MAINNET_KEY!,
      mainnet: ETHERESCAN_MAINNET_KEY!,
    }
  }
};

export default config;