//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2;


import "@openzeppelin/contracts/utils/Context.sol" ;
import { SafeERC20 , IERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol" ;
import { FeeChargerComponentERC20 } from "./components/FeeChargerComponentERC20.sol" ;
import { FeeChargerComponentAmountStatic } from "./components/FeeChargerComponentAmountStatic.sol" ;


contract FeeChargerERC20 is FeeChargerComponentERC20, FeeChargerComponentAmountStatic {

    using SafeERC20 for IERC20 ;

    constructor(address feeToken_, uint256 feeAmount_) FeeChargerComponentERC20(feeToken_) FeeChargerComponentAmountStatic(feeAmount_) {}

    /// @dev Non `address(0)-destination-safe`
    function _chargeFees(address feeReceiver) internal virtual {
        address feePayer = _msgSender() ;
        uint256 fee = _feeAmount ;

        _feeToken.safeTransferFrom(feePayer, feeReceiver, fee) ;
        emit FeeCharged(feePayer, address(_feeToken), fee) ;
    }

}
