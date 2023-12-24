//SPDX-License-Identifier: MIT
pragma solidity ^0.8.23 ;
pragma abicoder v2;


import { SafeERC20, IERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol" ;
import { FeeManagerComponentERC20 } from "./components/FeeManagerComponentERC20.sol" ;
import { FeeManagerComponentAmountStatic } from "./components/FeeManagerComponentAmountStatic.sol" ;


contract FeeManagerERC20 is FeeManagerComponentERC20, FeeManagerComponentAmountStatic {

    using SafeERC20 for IERC20 ;

    constructor(address feeToken_, uint256 feeAmount_) {}

    /// @dev Non `reentrancy-safe` and non `address(0)-destination-safe`
    function _chargeFees(address feeCollector, address feePayer, address feeReceiver) internal virtual {
        uint256 fee = feeAmount(feeCollector) ;
        _feeToken.safeTransferFrom(feePayer, feeReceiver, fee) ;
        emit FeeCharged(feeCollector, feePayer, address(_feeToken), fee) ;
    }

}
