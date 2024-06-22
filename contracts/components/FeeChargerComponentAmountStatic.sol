//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


/**
 * @title FeeChargerComponentAmountStatic
 * @dev No access control mechanis is used by default, it must be configured by
 *      developer according to applications needs
 */
abstract contract FeeChargerComponentAmountStatic {

    uint256 internal _feeAmount ;

    event FeeAmountChanged(uint256 oldFeeAmount, uint256 newFeeAmount) ;

    constructor(uint256 feeAmount_) {
        _feeAmount = feeAmount_ ;
    }

    function _setFeeAmount(uint256 newFeeAmount) internal virtual {
        uint256 oldFeeAmount = _feeAmount ;
        _feeAmount = newFeeAmount ;
        emit FeeAmountChanged(oldFeeAmount,newFeeAmount) ;
    }

}
