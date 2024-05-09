//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25 ;
pragma abicoder v2 ;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/// @title MockERC20Token
contract MockERC20Token is ERC20 {

  constructor(string memory name_, string memory symbol_, address owner, uint256 initialBalance) ERC20(name_, symbol_) {
      _mint(owner, initialBalance);
  }

}
