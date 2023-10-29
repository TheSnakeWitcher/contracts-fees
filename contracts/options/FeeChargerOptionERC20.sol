//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol" ;


contract FeeChargerOptionERC20 is Context {

    IERC20 private _feeToken ;

    event FeeTokenChanged(address oldFeeToken, address newFeeToken) ;
    event FeeCharged(address indexed feePayer,address indexed feeTokenCharged, uint256 feeAmount) ;

    constructor(address feeToken_) {
        _feeToken = IERC20(feeToken_) ;
    }

    function feeToken() public view returns (IERC20) {
        return _feeToken ;
    }

    function _setFeeToken(address newFeeToken) internal {
        address oldFeeToken = address(_feeToken) ;
        _feeToken = IERC20(newFeeToken) ;
        emit FeeTokenChanged(oldFeeToken,newFeeToken) ;
    }

}
