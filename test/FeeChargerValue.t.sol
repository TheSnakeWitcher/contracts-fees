// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;


import { Test, console2 } from "../lib/forge-std/src/Test.sol";
import { MockFeeChargerValue as FeeChargerValue } from "../contracts/mocks/MockFeeChargerValue.sol";
import { FeeChargerComponentValue } from "../contracts/components/FeeChargerComponentValue.sol" ;


uint256 constant FEE_AMOUNT = 10 gwei ;


contract FeeChargerValueTest is Test {

    FeeChargerValue public testContract ;

    address owner = vm.addr(1) ;
    address user = vm.addr(2) ;

    function setUp() public {
        testContract = new FeeChargerValue(FEE_AMOUNT);
    }

    function test_feeAmount() public {
        uint256 contractFeeAmount = testContract.feeAmount() ;
        assertEq(contractFeeAmount, FEE_AMOUNT) ;
    }

    function test_chargeFeesTransferSpecifiedAmount() public {
        hoax(user, 2 * FEE_AMOUNT);
        testContract.chargeFees{ value: FEE_AMOUNT }(owner);
        assertEq(owner.balance, FEE_AMOUNT);
    }

    function test_chargeFeesRevertsWhenInssuficientValue() public {
        hoax(user, 2 * FEE_AMOUNT);
        vm.expectRevert();
        testContract.chargeFees{value: FEE_AMOUNT / 2}(owner) ;
    }

}
