import { Contract } from '@ethersproject/contracts';
import { expect } from 'chai';
import { ethers } from 'hardhat'

describe("Flashloan", () => {

  let flashloanContract: Contract

  it("should deploy Flashloan contract", async function () {
    const [owner] = await ethers.getSigners();

    const contractInstance = await ethers.getContractFactory('Flashloan');

    flashloanContract = await contractInstance.deploy('0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5');

    expect(!!flashloanContract.address).to.equal(true);
  });
});