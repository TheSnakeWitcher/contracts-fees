//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2 ;


import "@openzeppelin/contracts/access/Ownable.sol" ;
import { FeeChargerValue } from "../FeeChargerValue.sol" ;


/// @title FeeChargerValueOwnable
contract FeeChargerValueOwnable is FeeChargerValue, Ownable {

    constructor(uint256 feeAmount_, address owner_) FeeChargerValue(feeAmount_) Ownable(owner_) {}

    function setFeeAmount(uint256 newFeeAmount) external virtual onlyOwner {
        _setFeeAmount(newFeeAmount);
    }

}
