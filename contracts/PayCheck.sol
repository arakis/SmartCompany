//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PayCheck {
    // string private greeting;

    // constructor(string memory _greeting) {
    //     console.log("Deploying a Greeter with greeting:", _greeting);
    //     greeting = _greeting;
    // }

    // function greet() public view returns (string memory) {
    //     return greeting;
    // }

    // function setGreeting(string memory _greeting) public {
    //     console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
    //     greeting = _greeting;
    // }

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    IERC20 private token;
    //address private token;
    int private balance;

    function depositCash(int amount) public {
        balance += amount;
    }

    function uploadHours(int numHours) public {

    }

}
