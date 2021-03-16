import { HardhatUserConfig } from "hardhat/config";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{ version: '0.7.4' }, { version: '0.6.8' }]
  }
};

export default config;