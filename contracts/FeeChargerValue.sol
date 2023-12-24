//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerComponentAmountStatic } from "./components/FeeChargerComponentAmountStatic.sol" ;
import { FeeChargerComponentValue } from "./components/FeeChargerComponentValue.sol" ;


contract FeeChargerValue is FeeChargerComponentValue, FeeChargerComponentAmountStatic {

    using Address for address payable ;

    constructor(uint256 feeAmount_) FeeChargerComponentAmountStatic(feeAmount_) {}

    /// @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
    function _chargeFees(address feeCollector) internal virtual {
        uint256 fee = feeAmount()  ;
        if ( msg.value < fee ) revert InsufficientValue() ;

        payable(feeCollector).sendValue(fee) ;
        emit FeeCharged(_msgSender(),fee) ;
    }

}
