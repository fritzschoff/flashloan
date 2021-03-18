import { HardhatUserConfig } from "hardhat/config";
import '@nomiclabs/hardhat-waffle'
import * as dotenv from 'dotenv';

dotenv.config()

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{ version: '0.7.4' }, { version: '0.6.8' }],
  },
  networks: {
    hardhat: {
      forking: {
        url: process.env['alchemy'] as string,
        blockNumber: 12063873
      }
    }
  }
};

export default config;