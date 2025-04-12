// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {KipuBank} from "../src/KipuBank.sol";

contract CounterTest is Test {
    KipuBank public kbank;

    function setUp() public {
        uint256 _bankCap = 1 ether;
        kbank = new KipuBank(_bankCap);
    }

    function test_One() public {
        //kbank.increment();
        //assertEq(counter.number(), 1);
    }

    function test_Two(uint256 x) public {
        //kbank.setNumber(x);
        //assertEq(counter.number(), x);
    }
}
