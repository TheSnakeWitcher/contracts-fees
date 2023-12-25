//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2 ;


import "@openzeppelin/contracts/access/Ownable.sol" ;
import { FeeChargerValue } from "../FeeChargerValue.sol" ;


/// @title FeeManagerValueOwnable
contract FeeManagerValueOwnable is FeeChargerValue, Ownable {

    constructor(uint256 feeAmount_, address owner_) FeeChargerValue(feeAmount_) Ownable(owner_) {}

    function setFeeAmount(uint256 newFeeAmount) external virtual onlyOwner {
        _setFeeAmount(newFeeAmount);
    }

    function chargeFees(address feeReceiver) external virtual onlyOwner {
        _chargeFees(feeReceiver);
    }

}
