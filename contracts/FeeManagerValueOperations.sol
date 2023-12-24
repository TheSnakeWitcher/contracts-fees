//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeManagerComponentValue } from "./components/FeeManagerComponentValue.sol" ;
import { FeeManagerComponentAmountOperations } from "./components/FeeManagerComponentAmountOperations.sol" ;


contract FeeManagerValueOperations is FeeManagerComponentValue, FeeManagerComponentAmountOperations {

    using Address for address payable ;

    constructor(uint256 defaultFeeAmount_) FeeManagerComponentAmountOperations(defaultFeeAmount_) {}

    /// @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
    function _chargeFees(address feeCollector, bytes4 functionSelector, address feePayer, address feeReceiver) internal virtual {
        uint256 fee = feeAmount(feeCollector, functionSelector) ;
        if ( msg.value < fee ) revert InsufficientValue() ;

        payable(feeReceiver).sendValue(fee) ;
        emit FeeCharged(feeCollector, feePayer, fee) ;
    }

}
