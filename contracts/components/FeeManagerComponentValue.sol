//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Context.sol" ;


contract FeeManagerComponentValue is Context {

    error InsufficientValue() ;

    event FeeCharged(address indexed feeCollector, address indexed feePayer, uint256 amount) ;

    function _checkValue(uint256 fee) internal view {
        if ( msg.value < fee ) revert InsufficientValue() ;
    }

}
