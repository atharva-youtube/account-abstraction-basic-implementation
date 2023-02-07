const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const [owner, acc1] = await ethers.getSigners();
  console.log(`Account 1 - ${owner.address}`);
  console.log(`Account 2 - ${acc1.address}`);

  const Account = await hre.ethers.getContractFactory("Account");
  const account = await Account.deploy(acc1.address, "Some account contract");

  await account.deployed();

  console.log(`Account contract deployed! Address - ${account.address}`);

  const Dummy = await hre.ethers.getContractFactory("Dummy");
  const dummy = await Dummy.deploy();

  await dummy.deployed();

  console.log(`Dummy contract deployed! Address - ${dummy.address}`);

  // Read dummy contract, call it through account contract and read again
  console.log(`Dummy contract value - ${await dummy.counter()}`);
  const unsignedTxn = await dummy.populateTransaction.increment();
  await account.connect(owner).call(dummy.address, unsignedTxn.data);
  console.log(`Increment function called!`);
  console.log(`Dummy contract value - ${await dummy.counter()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
