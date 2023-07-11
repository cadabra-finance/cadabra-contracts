import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-foundry";
import "@nomicfoundation/hardhat-toolbox";
// import "@nomicfoundation/hardhat-verify";
import '@openzeppelin/hardhat-upgrades';


import path from "path";
import dotenv from 'dotenv';

const env = dotenv.config({path: path.resolve(__dirname, '.env')});

const {
  PRIVATE_KEY,
  BSCSCAN_MAINNET_KEY,
} = env.parsed || {};


const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
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
      bsc: BSCSCAN_MAINNET_KEY,
    }
  }
};

export default config;