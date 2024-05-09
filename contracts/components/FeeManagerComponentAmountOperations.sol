//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "./constants.sol" ;


/// @title FeeManagerComponentAmountOperations
abstract contract FeeManagerComponentAmountOperations {

    mapping(address feeCollector => mapping(bytes4 functionSelector => uint256 feeAmount)) _feeAmounts ;

    event FeeAmountChanged(address feeCollector, bytes4 indexed functionSelector, uint256 oldFeeAmount, uint256 newFeeAmount) ;
    event FeeAmountsChanged(address feeCollector, bytes4[] indexed functionSelectors, uint256[] oldFeeAmounts, uint256[] newFeeAmounts) ;

    constructor(uint256 defaultFeeAmount_) {
        _feeAmounts[DEFAULT_FEE_COLLECTOR][DEFAULT_OPERATION] = defaultFeeAmount_ ;
    }

    function defaultFeeAmount() public view virtual returns (uint256) {
        return _feeAmounts[DEFAULT_FEE_COLLECTOR][DEFAULT_OPERATION] ;
    }

    function defaultFeeAmount(address feeCollector) public view virtual returns (uint256) {
        return _feeAmounts[feeCollector][DEFAULT_OPERATION] ;
    }

    function feeAmount(address feeCollector, bytes4 functionSelector) public view virtual returns (uint256) {
        uint256 fee = _feeAmounts[feeCollector][functionSelector] ;
        if (fee != 0) return fee ;

        fee = defaultFeeAmount(feeCollector) ;
        if ( fee != 0 ) return fee ;

        return defaultFeeAmount();
    }

    function _setDefaultFeeAmount(uint256 newFeeAmount) internal virtual {
        _setFeeAmount(DEFAULT_FEE_COLLECTOR, DEFAULT_OPERATION, newFeeAmount) ;
    }

    function _setDefaultFeeAmount(address feeCollector, uint256 newFeeAmount) internal virtual {
        _setFeeAmount(feeCollector, DEFAULT_OPERATION, newFeeAmount) ;
    }

    function _setFeeAmount(address feeCollector, bytes4 functionSelector, uint256 newFeeAmount) internal virtual {
        uint256 oldFeeAmount = _feeAmounts[feeCollector][functionSelector] ;
        _feeAmounts[feeCollector][functionSelector] = newFeeAmount ;
        emit FeeAmountChanged(feeCollector, functionSelector, oldFeeAmount, newFeeAmount) ;
    }

    function _setFeeAmounts(address feeCollector, bytes4[] calldata functionSelectors, uint256[] calldata newFeeAmounts) internal virtual {
        uint256 feeAmountNumber = newFeeAmounts.length ;
        if ( feeAmountNumber != functionSelectors.length ) revert() ;

        uint256[] memory oldFeeAmounts = new uint256[](feeAmountNumber) ;
        for(uint i=0 ; i < feeAmountNumber ; ++i ) {
            bytes4 currentFunctionSelector  = functionSelectors[i] ;
            oldFeeAmounts[i] = feeAmount(feeCollector, currentFunctionSelector) ;
            _feeAmounts[feeCollector][currentFunctionSelector] = newFeeAmounts[i];
        }

        emit FeeAmountsChanged(feeCollector, functionSelectors, oldFeeAmounts, newFeeAmounts) ;
    }

}
