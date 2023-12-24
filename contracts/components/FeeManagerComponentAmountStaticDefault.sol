//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import "./FeeManagerComponentAmountStatic.sol" ;


/// @title FeeManagerComponentAmountStaticDefault
abstract contract FeeManagerComponentAmountStaticDefault is FeeManagerComponentAmountStatic {

    uint256 private _defaultFeeAmount ;

    constructor(uint256 defaultFeeAmount_) {
        _defaultFeeAmount = defaultFeeAmount_ ;
    }

    function feeAmount() public view virtual returns (uint256) {
        return _defaultFeeAmount ;
    }

    function feeAmount(address feeCollector) public view virtual override returns (uint256) {
        uint256 fee = super.feeAmount(feeCollector) ;
        if (fee != 0) return fee ;
        return feeAmount() ;
    }

    function _setDefaultFeeAmount(uint256 newFeeAmount) internal virtual {
        _defaultFeeAmount = newFeeAmount ;
    }

}
