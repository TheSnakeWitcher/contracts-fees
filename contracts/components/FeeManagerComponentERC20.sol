//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol" ;
import "@openzeppelin/contracts/utils/Context.sol" ;


contract FeeManagerComponentERC20 is Context {

    mapping(address feeCollector => IERC20 feeToken) private _feeToken ;

    event FeeTokenChanged(address indexed feeCollector, address oldFeeToken, address newFeeToken) ;
    event FeeCharged(address indexed feeCollector, address indexed feePayer,address indexed feeTokenCharged, uint256 feeAmount) ;

    function feeToken(address feeCollector) public view returns (IERC20) {
        return _feeToken[feeCollector] ;
    }

    function _setFeeToken(address feeCollector, address newFeeToken) internal {
        address oldFeeToken = feeToken(feeCollector);
        _feeToken[feeCollector] = IERC20(newFeeToken) ;
        emit FeeTokenChanged(feeCollector, oldFeeToken, newFeeToken) ;
    }

}
