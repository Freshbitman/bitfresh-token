const BitfreshToken = artifacts.require("BitfreshToken");
const TokenVestingFactory = artifacts.require("TokenVestingFactory");
const TokenTimelock = artifacts.require("TokenTimelock");
const TokenVesting = artifacts.require("TokenVesting");

module.exports = function(deployer, network , address) {
  deployer.deploy(TokenVestingFactory,  address[0]);
  deployer.deploy(BitfreshToken, 'BitfreshToken', 'BFT', '1000000000000000000000000000', 18);
};
