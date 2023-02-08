
# Project Title

A smart contract that can use in a basic realtionship between manufactures and clients


## Authors

- [@danirr95](https://www.github.com/danirr95)


## Deployment

```bash
First, you have to download Ganache software from his official site -> https://trufflesuite.com/ganache/

Ganache create a blockchain for deploy our dApps
```
```bash
Once you installed Ganache, then go to configuration inside Ganache and copy the hostname, port number and the network ID
```
```bash
Put the hostname, port number and the network ID on the file 'truffle-config.js' that you cand find in the root of the project -> 

module.exports = {
    networks: {
    development: {
        host: "127.0.0.1",     // Localhost (default: none)
        port: 7545,            // Standard Ethereum port (default: none)
        network_id: "*",       // Any network (default: none)
        },
    }
}
```
```bash
It's very important that you keep Ganache open
```
```bash
After that, you can execute the project just openning the console in VSCode and run the following command -> truffle deploy –reset
```
```bash
Now you must have the project running, so for do some test on the contract, you have to enter in the truffle console with the following command -> truffle console
```
```bash
Inside of the truffle console you can execute, for example this codes for create a users -> 

supplyChain.deployed().then(function(instance) {return instance.createParticipant("A","passA","0x436f6e677261747320796f7520666f756e642045", "Manufacturer") });

supplyChain.deployed().then(function(instance) {return instance.createParticipant("B","passB","0x6173746572206567672120452d6d61696c20676d", "Supplier") });

supplyChain.deployed().then(function(instance) {return instance.createParticipant("C","passC","0x61726b40676d61726b2e636f6d20746f2077696e", "Consumer") });
```
```bash
After that you can obtain the info about each user that you created with this command ->

supplyChain.deployed().then(function(instance) {return instance.getParticipantDetails(0)});

supplyChain.deployed().then(function(instance) {return instance.getParticipantDetails(1)});

supplyChain.deployed().then(function(instance) {return instance.getParticipantDetails(2)});

```
```bash
And the last recommendation is that create a product and realise a transfer of that product between two of the created users with the following command ->

upplyChain.deployed().then(function(instance) {return instance.createProduct(0,"prodABC","100", "123", 11) });

supplyChain.deployed().then(function(instance) {return instance.transferToOwner(0, 1, 0) })
```
```bash
I hope that you enjoy the project!

Thanks for your time
```
## 🔗 Links
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/daniel-ruiz-rivera-955818207/)



## License

[MIT](https://choosealicense.com/licenses/mit/)

