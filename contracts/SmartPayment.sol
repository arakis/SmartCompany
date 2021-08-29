//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SmartPayment {

    // Address of the Employer
    address private payerAddress;

    // Address of the Contractor
    address private recipientAddress;

    // Payment Currency
    IERC20 private currencyToken;

    // When should the contract start?
    uint private contractStart;

    // How many should payed per minute?
    uint256 private paymentPerMinute;

    // How many minutes where already submitted and payed?
    uint private payedMinutes;

    constructor(
        address _currencyTokenAddress,
        address _payerAddress,
        address _recipientAddress
    ) {
        currencyToken = IERC20(_currencyTokenAddress);
        payerAddress = _payerAddress;
        recipientAddress = _recipientAddress;
        contractStart = block.timestamp;
    }

    function setContractStart(uint timestamp) public {
        require(msg.sender == payerAddress, "Permission denied");
        require(payedMinutes == 0, "ContractStart cannot modified after first payment");

        contractStart = timestamp;
    }

    function depositCash(uint256 amount) public {
        currencyToken.transferFrom(payerAddress, address(this), amount);
    }

    function withdrawCash(uint256 amount) public {
        require(msg.sender == payerAddress, "Permission denied");
        currencyToken.transfer(payerAddress, amount);
    }

    function getBudget() public view returns (uint256) {
        return currencyToken.balanceOf(address(this));
    }

    function submitWorkTime(uint numMinutes) public {
        require(msg.sender == recipientAddress, "Permission denied");
        require(numMinutes < 60 * 24, "Too many minutes");

        uint maxMinutes = (block.timestamp - contractStart) / 60;
        require(payedMinutes + numMinutes <= maxMinutes, "Too much work");

        uint256 amount = paymentPerMinute * uint256(numMinutes);

        currencyToken.transfer(recipientAddress, amount);
        payedMinutes += numMinutes;
        
        // contractStart = block.timestamp; // TODO: Think about better solution
    }

}
