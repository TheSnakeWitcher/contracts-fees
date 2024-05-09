//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerComponentAmountStatic } from "./components/FeeChargerComponentAmountStatic.sol" ;
import { FeeChargerComponentValue } from "./components/FeeChargerComponentValue.sol" ;


contract FeeChargerValue is FeeChargerComponentValue, FeeChargerComponentAmountStatic {

    using Address for address payable ;

    constructor(uint256 feeAmount_) FeeChargerComponentAmountStatic(feeAmount_) {}

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`. Must be called in a
     *      external or public payable function.All ether left over at the end of transaction
     *      when calling a payable function is keep in the called contract
     */ 
    function _chargeFees(address feeReceiver) internal virtual {
        uint256 fee = feeAmount()  ;
        _checkValue(fee) ;

        payable(feeReceiver).sendValue(fee) ;
        emit FeeCharged(_msgSender(),fee) ;
    }

}
