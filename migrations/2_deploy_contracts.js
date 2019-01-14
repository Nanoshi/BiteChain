
var BiteChain = artifacts.require("./BiteChain.sol");

module.exports = function(deployer) {
  deployer.deploy(BiteChain);
};