//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


contract FeeChargerOptionValue is Context {

    error InsufficientMsgValue() ;

    event FeeCharged(address indexed feePayer, uint256 amount) ;

}
