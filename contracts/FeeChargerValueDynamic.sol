//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Address.sol" ;
import { FeeChargerComponentValue } from "./components/FeeChargerComponentValue.sol" ;


abstract contract FeeChargerValueDynamic is FeeChargerComponentValue {

    using Address for address payable ;

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`. Must be called in a
     *      external or public payable function.All ether left over at the end of transaction
     *      when calling a payable function is keep in the called contract
     */ 
    function _chargeFees(address feeCollector, bytes calldata feeParams) internal virtual {
        uint256 fee = _calculateFee(feeParams)  ;
        _checkValue(fee) ;

        payable(feeCollector).sendValue(fee) ;
        emit FeeCharged(_msgSender(),fee) ;
    }

    /**
     * @param params are byte-encoded parameters needed to calculate current fee
     * @return current fee to charge by `_chargeFees()`
     */
    function _calculateFee(bytes calldata params) internal virtual returns (uint256) ;

}
