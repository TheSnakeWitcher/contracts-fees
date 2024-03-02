//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerComponentValue } from "./components/FeeChargerComponentValue.sol" ;
import { FeeChargerComponentAmountOperations, DEFAULT_OPERATION } from "./components/FeeChargerComponentAmountOperations.sol" ;


contract FeeChargerOperationsValue is FeeChargerComponentValue, FeeChargerComponentAmountOperations {

    using Address for address payable ;

    constructor(uint256 feeAmount_) FeeChargerComponentAmountOperations(feeAmount_) {}

    /// @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
    function _chargeFees(address feeCollector) internal virtual {
        _chargeFees(feeCollector,DEFAULT_OPERATION);
    }

    /// @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
    function _chargeFees(address feeCollector, bytes4 functionSelector) internal virtual {
        uint256 fee = feeAmount(functionSelector)  ;
        _checkValue(fee) ;

        payable(feeCollector).sendValue(fee) ;
        emit FeeCharged(_msgSender(), fee) ;
    }

}
