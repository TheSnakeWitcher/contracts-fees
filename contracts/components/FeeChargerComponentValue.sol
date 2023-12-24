//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;

import "@openzeppelin/contracts/utils/Context.sol" ;

contract FeeChargerComponentValue is Context {

    error InsufficientValue() ;

    event FeeCharged(address indexed feePayer, uint256 amount) ;

}
