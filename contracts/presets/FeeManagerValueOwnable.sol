//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2 ;


import "@openzeppelin/contracts/access/Ownable.sol" ;
import { FeeManagerValue } from "../FeeManagerValue.sol" ;


/// @title FeeManagerValueOwnable
contract FeeManagerValueOwnable is FeeManagerValue, Ownable {

    constructor(uint256 defaultfeeAmount_, address owner_) FeeManagerValue(defaultfeeAmount_) Ownable(owner_) {}

    function setDefaultFeeAmount(uint256 newFeeAmount) external virtual onlyOwner {
        _setDefaultFeeAmount(newFeeAmount);
    }

    function setFeeAmount(address feeCollector, uint256 newFeeAmount) external virtual onlyOwner {
        _setFeeAmount(feeCollector, newFeeAmount);
    }

}
