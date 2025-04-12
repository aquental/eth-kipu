// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {KipuBank} from "../src/KipuBank.sol";

contract KipuBankScript is Script {
    KipuBank public kbank;

    function setUp() public {}

    /*
    function run() public {
        vm.startBroadcast();

        kbank = new KipuBank(1 ether);

        vm.stopBroadcast();
    }
    */
    function run() external {
        uint256 bankCap = 10 ether; // Constructor parameter for bank cap
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Start broadcasting transactions to the network
        vm.startBroadcast(deployerPrivateKey);

        // Deploy KipuBank with bankCap
        KipuBank kipuBank = new KipuBank(bankCap);

        // Stop broadcasting
        vm.stopBroadcast();

        // Log the deployed contract address
        console.log("KipuBank deployed to:", address(kipuBank));
    }
}
