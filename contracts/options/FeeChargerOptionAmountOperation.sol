//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


const bytes4 DEFAULT_OPERATION = bytes4(0) ;


/**
 * @title FeeChargerOperations
 * @dev No access control mechanis is used by default, it must be configured by
 *      developer according to applications needs
 */
abstract contract FeeChargerOptionAmountOperations {

    event FeeAmountChanged(bytes4 indexed functionSelector, uint256 oldFeeAmount, uint256 newFeeAmount) ;

    mapping(bytes4 functionSelector => uint256 fee) _feeAmounts ;

    constructor(uint256 feeAmount_) {
        _feeAmounts[DEFAULT_OPERATION] = feeAmount_ ;
    }

    function feeAmount(bytes4 functionSelector) public view virtual returns (uint256) {
        // return _feeAmounts[functionSelector] ;
        uint256 fee = _feeAmounts[functionSelector] ;
        if (fee != 0) return fee ;
        return _feeAmounts[DEFAULT_OPERATION];
    }

    function _setFeeAmount(bytes4 functionSelector,uint256 newFeeAmount) internal virtual {
        uint256 oldFeeAmount = _feeAmounts[functionSelector] ;
        _feeAmounts[functionSelector] = newFeeAmount ;
        emit FeeAmountChanged(functionSelector,oldFeeAmount,newFeeAmount) ;
    }

}
