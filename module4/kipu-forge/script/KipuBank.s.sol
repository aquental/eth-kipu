// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {KipuBank} from "../src/KipuBank.sol";

contract CounterScript is Script {
    KipuBank public kbank;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        kbank = new KipuBank(1 ether);

        vm.stopBroadcast();
    }
}
