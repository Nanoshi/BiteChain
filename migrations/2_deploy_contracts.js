
var BiteChain = artifacts.require("./BiteChain.sol");
//var Amazon = artifacts.require("./Amazon.sol");

module.exports = function(deployer) {
  deployer.deploy(BiteChain);
  //deployer.deploy(Amazon);
};