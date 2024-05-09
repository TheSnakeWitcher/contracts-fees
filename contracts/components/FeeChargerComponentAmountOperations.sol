//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "./constants.sol" ;


/**
 * @title FeeChargerComponentAmountOperations
 * @dev No access control mechanism is used by default, it must be configured by
 *      developer according to applications needs
 */
abstract contract FeeChargerComponentAmountOperations {

    mapping(bytes4 functionSelector => uint256 fee) _feeAmounts ;

    event FeeAmountChanged(bytes4 indexed functionSelector, uint256 oldFeeAmount, uint256 newFeeAmount) ;

    constructor(uint256 feeAmount_) {
        _feeAmounts[DEFAULT_OPERATION] = feeAmount_ ;
    }

    function feeAmount(bytes4 functionSelector) public view virtual returns (uint256) {
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
