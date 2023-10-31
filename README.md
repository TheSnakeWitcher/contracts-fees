# Fee management 

A solidity library for fee management

## Structure

Contracts are divided in those who charge fee using native cryptocurrency(which have `Value` in their name) or ERC20 tokens(which have `ERC20` in their name).

* Contracts `FeeChargerValue` and `FeeChargerERC20` obtain the fee amount to charge by reading a predefined state variable(statically).
* Contracts `FeeChargerValueDynamic` and `FeeChargerERC20Dynamic` calculate the current fee acording to arbitrary parameters(dynamically).
* Contracts `FeeChargerValueOperations` and `FeeChargerERC20Operations` allow to define a fee amount for every function and charge accordingly
to current function being called, aditionally allow to define a default fee.
