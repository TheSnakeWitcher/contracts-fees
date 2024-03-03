//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol" ;

import { FeeManagerComponentValue } from "./components/FeeManagerComponentValue.sol" ;
import { FeeManagerComponentAmountStatic } from "./components/FeeManagerComponentAmountStatic.sol" ;


contract FeeChargerValueInternal is FeeManagerComponentValue, FeeManagerComponentAmountStatic, ReentrancyGuard {

    using Address for address payable ;

    constructor(uint256 defaultFeeAmount_) FeeManagerComponentAmountStatic(defaultFeeAmount_) {}

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`. Must be called in a
     *      external or public payable function.All ether left over at the end of transaction
     *      when calling a payable function is keep in the called contract
     */ 
    function _chargeFees(address feeCollector, address feePayer) internal virtual {
        uint256 fee = feeAmount(feeCollector) ;
        _checkValue(fee) ;
        emit FeeCharged(feeCollector, feePayer, fee) ;
    }

    /// @dev Non`reentrancy-safe` and non `address(0)-destination-safe`. Must be called in a
    function _withdraw(address payable recipient, uint256 amount) internal virtual nonReentrant {
        Address.sendValue(recipient, amount);
    }

}
