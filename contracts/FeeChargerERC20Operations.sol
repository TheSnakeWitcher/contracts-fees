//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Context.sol" ;
import { SafeERC20 , IERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol" ;
import { FeeChargerComponentERC20 } from "./components/FeeChargerComponentERC20.sol" ;
import { FeeChargerComponentAmountOperations, DEFAULT_OPERATION } from "./components/FeeChargerComponentAmountOperations.sol" ;


contract FeeChargerERC20Operations is FeeChargerComponentERC20, FeeChargerComponentAmountOperations {

    using SafeERC20 for IERC20 ;

    constructor(address feeToken_,uint256 feeAmount_) FeeChargerComponentERC20(feeToken_) FeeChargerComponentAmountOperations(feeAmount_) {}

    /// @dev Non `address(0)-destination-safe`
    function _chargeFees(address feeCollector) internal {
        _chargeFees(feeCollector, DEFAULT_OPERATION);
    }

    /// @dev Non `address(0)-destination-safe`
    function _chargeFees(address feeCollector, bytes4 functionSelector) internal virtual {
        address feePayer = _msgSender() ;
        uint256 fee = feeAmount(functionSelector) ;

        _feeToken.safeTransferFrom(feePayer, feeCollector, fee) ;
        emit FeeCharged(feePayer, address(_feeToken), fee) ;
    }

}
