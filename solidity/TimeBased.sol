// SPDX-License-Identifier: MIT  
pragma solidity ^0.8.0;

contract TimeBased {  
    uint256 public counter = 0;

    function count() public {  
        counter += 1;  
    }  
}