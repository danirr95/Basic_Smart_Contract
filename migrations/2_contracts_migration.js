//Importamos el archivo con nuestro contrato creado
//const HelloWorld = artifacts.require("HelloWorld");
const erc20Token = artifacts.require("./erc20Token.sol");
const SupplyChain = artifacts.require("./SupplyChain.sol");

//Exportamos la ejecución de la función deploy, la cual recibe cada uno de los archivos (contratos) creados
module.exports = function (deployer) {
    //deployer.deploy(HelloWorld);
    deployer.deploy(erc20Token, 10000, "MGS Token", 18, "MGS");
    deployer.deploy(SupplyChain);
};