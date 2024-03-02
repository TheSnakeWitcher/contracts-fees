//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "./constants.sol" ;


/// @title FeeManagerComponentAmountStatic
abstract contract FeeManagerComponentAmountStatic {

    mapping(address feeCollector => uint256 feeAmount) private _feeAmount ;

    event FeeAmountChanged(address feeCollector, uint256 oldFeeAmount, uint256 newFeeAmount) ;

    constructor(uint256 defaultFeeAmount_) {
        _feeAmount[DEFAULT_FEE_COLLECTOR] = defaultFeeAmount_ ;
    }

    function feeAmount() public view virtual returns (uint256) {
        return _feeAmount[DEFAULT_FEE_COLLECTOR] ;
    }

    /// @dev maybe call it feesOf ?
    function feeAmount(address feeCollector) public view virtual returns (uint256) {
        uint256 fee = _feeAmount[feeCollector] ;
        if (fee != 0) return fee ;
        return feeAmount() ;
    }

    function _setDefaultFeeAmount(uint256 newFeeAmount) internal virtual {
        _setFeeAmount(DEFAULT_FEE_COLLECTOR, newFeeAmount) ;
    }

    function _setFeeAmount(address feeCollector, uint256 newFeeAmount) internal virtual {
        uint256 oldFeeAmount = feeAmount(feeCollector) ;
        _feeAmount[feeCollector] = newFeeAmount ;
        emit FeeAmountChanged(feeCollector, oldFeeAmount, newFeeAmount) ;
    }

}
