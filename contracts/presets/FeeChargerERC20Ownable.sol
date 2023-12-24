//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2 ;


import "@openzeppelin/contracts/access/Ownable.sol" ;
import { FeeChargerERC20 } from "../FeeChargerERC20.sol" ;


/// @title FeeChargerERC20Ownable
contract FeeChargerERC20Ownable is FeeChargerERC20, Ownable {

    constructor(address feeToken_, uint256 feeAmount_, address owner) FeeChargerERC20(feeToken_, feeAmount_) Ownable(owner) {}

    function setFeeToken(address newFeeToken) external onlyOwner {
        _setFeeToken(newFeeToken) ;
    }

    function setFeeAmount(uint256 newFeeAmount) external onlyOwner {
        _setFeeAmount(newFeeAmount);
    }

    function chargeFees(address feeCollector) external virtual onlyOwner {
        _chargeFees(feeCollector) ;
    }

}
