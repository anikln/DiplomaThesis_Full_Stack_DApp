var Project = artifacts.require("./Project.sol");
var Factoryproject = artifacts.require("./Factoryproject.sol");
var Personal=artifacts.require("./Personal.sol");

module.exports = function(deployer) {
  deployer.deploy(Project);
  deployer.deploy(Factoryproject);
};

