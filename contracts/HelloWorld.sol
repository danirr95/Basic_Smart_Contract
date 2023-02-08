//SPDX-License-Identifier: MIT

///@title Basic Smart Contract
///@author Daniel Ruiz Rivera
///@notice Basic HelloWorld program

//Compiler version
pragma solidity ^0.8.17;    //pragma solidity >= 0.6.0 < 0.8.0

contract HelloWorld {
    string private helloMessage = "Hello World";

    function getHelloWorld() public view returns (string memory) { 
        return helloMessage;
    }
}
