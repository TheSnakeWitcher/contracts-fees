//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerOptionAmountStatic } from "./options/FeeChargerOptionAmountStatic.sol" ;
import { FeeChargerOptionValue } from "./options/FeeChargerOptionValue.sol" ;


contract FeeChargerValue is FeeChargerOptionValue, FeeChargerOptionAmountStatic {

    using Address for address payable ;

    constructor(uint256 feeAmount_) FeeChargerOptionAmountStatic(feeAmount_) {}

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
     */
    function _chargeFees(address feeCollector) internal virtual override {
        uint256 fee = feeAmount()  ;
        if ( msg.value < fee ) revert InsufficientMsgValue() ;

        payable(feeCollector).sendValue(fee) ;
        emit FeeCharged(_msgSender(),fee) ;
    }

}
