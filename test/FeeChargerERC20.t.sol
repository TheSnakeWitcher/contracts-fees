// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;


import {Test, console2} from "forge-std/Test.sol";
import { MockERC20Token } from "../contracts/mocks/MockERC20Token.sol";
import { MockFeeChargerERC20 as FeeChargerERC20 } from "../contracts/mocks/MockFeeChargerERC20.sol";
import { FeeChargerComponentValue } from "../contracts/components/FeeChargerComponentValue.sol" ;
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol" ;


uint256 constant FEE_AMOUNT = 10 gwei ;


contract FeeChargerERC20Test is Test {

    FeeChargerERC20 public testContract ;
    IERC20 token ;

    address owner = vm.addr(1) ;
    address user = vm.addr(2) ;
    address user2 = vm.addr(3) ;

    function setUp() public {
        token = new MockERC20Token("testName","testSymbol", user, 2 * FEE_AMOUNT) ;
        testContract = new FeeChargerERC20(address(token), FEE_AMOUNT);
    }

    function test_hasSpecifiedFeeToken() public {
        address feeToken = address(testContract.feeToken()) ;
        assertEq(feeToken, address(token));
    }

    function test_hasSpecifiedFeeAmount() public {
        uint256 feeAmount = testContract.feeAmount() ;
        assertEq(feeAmount, FEE_AMOUNT);
    }

    function test_setSpecifiedFeeAmount(uint256 newFeeAmount) public {
        testContract.setFeeAmount(newFeeAmount) ;
        uint256 feeAmount = testContract.feeAmount() ;
        assertEq(feeAmount, newFeeAmount);
    }

    function test_chargeFeesTransferSpecifiedAmount() public {
        vm.startPrank(user);
        token.approve(address(testContract), FEE_AMOUNT) ;
        testContract.chargeFees(owner);
        assertEq(token.balanceOf(owner), FEE_AMOUNT);
    }

    function testFail_chargeFeesRevertsWhenInssuficientBalance() public {
        vm.prank(user) ;
        token.transfer(user2, FEE_AMOUNT / 2);

        vm.startPrank(user2);
        token.approve(address(testContract), FEE_AMOUNT) ;
        testContract.chargeFees(owner);
        assertEq(token.balanceOf(owner), FEE_AMOUNT);
    }

    function testFail_chargeFeesRevertsWhenInssuficientAllowance() public {
        vm.startPrank(user);
        token.approve(address(testContract), FEE_AMOUNT / 2) ;
        testContract.chargeFees(owner);
    }

}
