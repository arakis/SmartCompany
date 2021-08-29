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

    constructor(address _tokenAddress, address _bossAddress, address _workerAddress) {
        token = IERC20(_tokenAddress);
        bossAddress = _bossAddress;
        workerAddress = _workerAddress;
    }

    IERC20 private token;
    //address private token;
    uint256 private balance;
    address private bossAddress;
    address private workerAddress;
    uint256 private paymentPerMinute;

    function depositCash(uint256 amount) public {
        token.transferFrom(bossAddress, address(this), amount);
    }

    function viewBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function uploadHours(uint256 numMinutes) public {
        uint256 amount = paymentPerMinute * numMinutes;
        
    }

}
