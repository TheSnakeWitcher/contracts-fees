//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerOptionValue } from "./options/FeeChargerOptionValue.sol" ;
import { FeeChargerOptionAmountOperation, DEFAULT_OPERATION } from "./options/FeeChargerOptionAmountOperation.sol" ;


contract FeeChargerOperationsValue is FeeChargerOptionValue, FeeChargerOptionAmountOperation {

    using Address for address payable ;

    constructor(uint256 feeAmount_) FeeChargerOptionAmountOperation(feeAmount_) {}

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
     */
    function _chargeFees(address feeCollector) internal virtual override {
        _chargeFees(feeCollector,DEFAULT_OPERATION);
    }

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
     */
    function _chargeFees(address feeCollector, bytes4 functionSelector) internal virtual override {
        uint256 fee = feeAmount(functionSelector)  ;
        if ( msg.value < fee ) revert InsufficientMsgValue() ;

        payable(feeCollector).sendValue(fee) ;
        emit FeeCharged(_msgSender(),functionSelector,fee) ;
    }

}
