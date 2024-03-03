// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;


import { FeeChargerERC20 } from "../FeeChargerERC20.sol";


contract MockFeeChargerERC20 is FeeChargerERC20 {

    constructor(address feeToken_, uint256 feeAmount_) FeeChargerERC20(feeToken_, feeAmount_) {}

    function setFeeAmount(uint256 newFeeAmount) public payable {
        _setFeeAmount(newFeeAmount);
    }

    function chargeFees(address feeReceiver) public payable {
        _chargeFees(feeReceiver);
    }

}
