//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Context.sol" ;
import { SafeERC20 , IERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol" ;
import { FeeChargerOptionERC20 } from "./options/FeeChargerOptionERC20.sol" ;
import { FeeChargerOptionAmountStatic } from "./options/FeeChargerOptionAmountStatic.sol" ;


contract FeeChargerERC20 is FeeChargerOptionERC20, FeeChargerOptionAmountStatic , Context {

    using SafeERC20 for IERC20 ;

    constructor(address feeToken_, uint256 feeAmount_) FeeChargerOptionERC20(feeToken_) FeeChargerOptionAmountStatic(feeAmount_) {}

    /**
     * @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
     */
    function _chargeFees(address feeCollector) internal virtual override {
        address feePayer = _msgSender() ;
        uint256 fee = feeAmount() ;

        // feeToken().safeTransferFrom(feePayer,feeCollector,fee) ; // if _feeToken is private
        _feeToken.safeTransferFrom(feePayer,feeCollector,fee) ;
        emit FeeCharged(feePayer,address(_feeToken),fee) ;
    }

}
