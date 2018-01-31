var Turtle = artifacts.require("./Turtle.sol");

module.exports = function(deployer) {
  deployer.deploy(Turtle);
};
