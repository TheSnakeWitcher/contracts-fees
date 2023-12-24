//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol" ;
import "@openzeppelin/contracts/utils/Context.sol" ;


contract FeeManagerComponentERC20 is Context {

    IERC20 private _defaultFeeToken ;
    mapping(address feeCollector => IERC20 feeToken) internal _feeToken ;

    event FeeTokenChanged(address indexed feeCollector, address oldFeeToken, address newFeeToken) ;
    event FeeCharged(address indexed feeCollector, address indexed feePayer,address indexed feeTokenCharged, uint256 feeAmount) ;

    function defaultFeeToken() public view returns (IERC20) {
        return _defaultFeeToken ;
    }

    /**
     * @param feeCollector is one of a set of managed fee collectors
     * @return feeToken corresponding to `feeCollector`
     * @dev return defaultFeeToken if no `feeToken` is set for `feeCollector`
     */
    function feeToken(address feeCollector) public view returns (IERC20) {
        IERC20 token = _feeToken[feeCollector] ;
        if (address(token) != address(0) ) return token ;
        return _defaultFeeToken ;
    }

    /**
     * @param feeCollector is the fee collectors to set the fee to
     * @param newFeeToken in which specified `feeCollector` will charge fees
     */
    function _setFeeToken(address feeCollector, address newFeeToken) internal {
        address oldFeeToken = address(feeToken(feeCollector)) ;
        _feeToken[feeCollector] = IERC20(newFeeToken) ;
        emit FeeTokenChanged(feeCollector, oldFeeToken, newFeeToken) ;
    }

}
