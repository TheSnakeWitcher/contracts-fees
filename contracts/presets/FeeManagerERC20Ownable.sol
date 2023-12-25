//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2 ;


import "@openzeppelin/contracts/access/Ownable.sol" ;
import { FeeManagerERC20 } from "../FeeManagerERC20.sol" ;


/// @title FeeManagerERC20Ownable
contract FeeManagerERC20Ownable is FeeManagerERC20, Ownable {

    constructor(address defaultFeeToken_, uint256 defaultfeeAmount_, address owner_) FeeManagerERC20(defaultFeeToken_, defaultfeeAmount_) Ownable(owner_) {}

    function chargeFees(address feeCollector,address feePayer, address feeReceiver) external virtual onlyOwner {
        _chargeFees(feeCollector,feePayer, feeReceiver);
    }

    function setDefaultFeeAmount(uint256 newFeeAmount) external virtual onlyOwner {
        _setDefaultFeeAmount(newFeeAmount);
    }

    function setFeeAmount(address feeCollector, uint256 newFeeAmount) external virtual onlyOwner {
        _setFeeAmount(feeCollector, newFeeAmount);
    }

}
