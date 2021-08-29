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

    constructor(
        address _tokenAddress,
        address _bossAddress,
        address _workerAddress
    ) {
        token = IERC20(_tokenAddress);
        bossAddress = _bossAddress;
        workerAddress = _workerAddress;
        contractStart = block.timestamp;
    }

    uint256 private contractStart;
    IERC20 private token;
    address private bossAddress;
    address private workerAddress;
    uint256 private paymentPerMinute;
    uint256 private payedMinutes;

    // function setContractStart(uint timestamp) public {
    //     require(msg.sender == bossAddress, "Permission denied");

    //     contractStart = timestamp;
    // }

    function depositCash(uint256 amount) public {
        token.transferFrom(bossAddress, address(this), amount);
    }

    function withdrawCash(uint256 amount) public {
        require(msg.sender == bossAddress, "Permission denied");
        token.transfer(bossAddress, amount);
    }

    function getBudget() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function uploadHours(uint numMinutes) public {
        require(msg.sender == workerAddress, "Permission denied");
        require(numMinutes < 60 * 24, "Too many minutes");

        uint256 maxMinutes = (block.timestamp - contractStart) / 60;
        require(payedMinutes + numMinutes <= maxMinutes, "Too much work");

        uint256 amount = paymentPerMinute * uint256(numMinutes);

        token.transfer(workerAddress, amount);
        payedMinutes += numMinutes;
        contractStart = block.timestamp; // TODO: Ggf. andere Lösung überlegen. Denn so kann der nicht 2-3 Transaktionen hintereinander eingeben um z.b. künftig einen purpose anzugeben.
    }

}
