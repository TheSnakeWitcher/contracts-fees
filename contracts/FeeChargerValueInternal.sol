//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol" ;

import { FeeChargerComponentValue } from "./components/FeeChargerComponentValue.sol" ;
import { FeeChargerComponentAmountStatic } from "./components/FeeChargerComponentAmountStatic.sol" ;


contract FeeChargerValueInternal is FeeChargerComponentValue, FeeChargerComponentAmountStatic, ReentrancyGuard {

    using Address for address payable ;

    constructor(uint256 fee) FeeChargerComponentAmountStatic(fee) {}

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`. Must be called in a
     *      external or public payable function.All ether left over at the end of transaction
     *      when calling a payable function is keep in the called contract
     */ 
    function _chargeFees(address feePayer) internal virtual {
        uint256 fee = _feeAmount ;
        _checkValue(fee) ;
        emit FeeCharged(feePayer, fee) ;
    }

    /// @dev Non `address(0)-destination-safe`
    function _withdraw(address payable recipient) internal virtual nonReentrant {
        Address.sendValue(recipient, address(this).balance); // @NOTE: use PAY opcode when available 
    }

}
