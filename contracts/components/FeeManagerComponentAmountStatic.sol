//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


/**
 * @title FeeManagerComponentAmountStatic
 */
abstract contract FeeManagerComponentAmountStatic {

    mapping(address feeCollector => uint256 feeAmount) private _feeAmount ;

    event FeeAmountChanged(address feeCollector, uint256 oldFeeAmount, uint256 newFeeAmount) ;

    /// @dev maybe call it feesOf ?
    function feeAmount(address feeCollector) public view virtual returns (uint256) {
        return _feeAmount[feeCollector] ;
    }

    function _setFeeAmount(address feeCollector, uint256 newFeeAmount) internal virtual {
        uint256 oldFeeAmount = feeAmount(feeCollector) ;
        _feeAmount[feeCollector] = newFeeAmount ;
        emit FeeAmountChanged(feeCollector, oldFeeAmount, newFeeAmount) ;
    }

}
