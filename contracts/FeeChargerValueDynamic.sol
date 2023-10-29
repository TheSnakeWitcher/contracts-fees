//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerOptionValue } from "./options/FeeChargerOptionValue.sol" ;


contract FeeChargerValueDynamic is FeeChargerOptionValue {

    using Address for address payable ;

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
     */
    function _chargeFees(address feeCollector, bytes calldata feeParams) internal virtual {
        uint256 fee = _calculateFee(feeParams)  ;
        if ( msg.value < fee ) revert InsufficientMsgValue() ;

        payable(feeCollector).sendValue(fee) ;
        emit FeeCharged(_msgSender(),fee) ;
    }

    /**
     * @param params are byte-encoded parameters needed to calculate current fee
     * @return current fee to charge by `_chargeFees()`
     */
    function _calculateFee(bytes calldata params) internal virtual returns (uint256) ;

}
