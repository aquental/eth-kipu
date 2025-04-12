// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {KipuBank} from "../src/KipuBank.sol";

contract KipuBankTest is Test {
    KipuBank public kipuBank;
    address public owner = address(0x1);
    address public user1 = address(0x2);
    address public user2 = address(0x3);

    uint256 public constant BANK_CAP = 10 ether;
    uint256 public constant MAX_WITHDRAWAL = 1 ether;

    // Setup function to deploy the contract before each test
    function setUp() public {
        vm.prank(owner);
        kipuBank = new KipuBank(BANK_CAP);

        // Fund users for testing
        vm.deal(user1, 5 ether);
        vm.deal(user2, 5 ether);
    }

    // Test 1: Initial Configuration
    function testInitialConfiguration() public view {
        assertEq(kipuBank.i_bankCap(), BANK_CAP, "Bank cap not set correctly");
        assertEq(kipuBank.i_owner(), owner, "Owner not set correctly");
    }

    //Test 1.1:
    function testContractInitialBalance() public view {
        assertEq(
            address(kipuBank).balance,
            0,
            "Contract should have zero initial balance"
        );
    }

    // Test 2: Successful Deposit
    function testDeposit() public {
        uint256 depositAmount = 2 ether;

        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit KipuBank.Deposit(user1, depositAmount);
        kipuBank.kipubank_deposit{value: depositAmount}();

        assertEq(
            kipuBank.s_balances(user1),
            depositAmount,
            "User balance not updated"
        );
        assertEq(
            address(kipuBank).balance,
            depositAmount,
            "Contract balance not updated"
        );
    }

    // Test 3: Deposit Exceeds Bank Cap
    function testDepositExceedsBankCap() public {
        uint256 depositAmount = BANK_CAP + 1 ether;
        vm.expectRevert(
            abi.encodeWithSignature("Error(string)", "Deposit exceeds bank cap")
        );
        address(kipuBank).call{value: depositAmount}(
            abi.encodeWithSignature("kipubank_deposit()")
        );
    }

    // Test 4: Successful Withdrawal
    function testWithdrawal() public {
        // First deposit
        uint256 depositAmount = 2 ether;
        vm.prank(user1);
        kipuBank.kipubank_deposit{value: depositAmount}();

        // Withdraw
        uint256 withdrawAmount = 0.5 ether;
        uint256 initialUserBalance = user1.balance;

        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit KipuBank.Withdrawal(user1, withdrawAmount);
        kipuBank.kipubank_withdraw(withdrawAmount);

        assertEq(
            kipuBank.s_balances(user1),
            depositAmount - withdrawAmount,
            "User balance not updated after withdrawal"
        );
        assertEq(
            address(kipuBank).balance,
            depositAmount - withdrawAmount,
            "Contract balance not updated"
        );
        assertEq(
            user1.balance,
            initialUserBalance + withdrawAmount,
            "User ETH not received"
        );
    }

    // Test 5: Withdrawal Exceeds Balance
    function testWithdrawalExceedsBalance() public {
        uint256 withdrawAmount = 1 ether;

        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        kipuBank.kipubank_withdraw(withdrawAmount);
    }

    // Test 6: Withdrawal Exceeds Max Limit
    function testWithdrawalExceedsMaxLimit() public {
        // Deposit enough funds
        vm.prank(user1);
        kipuBank.kipubank_deposit{value: 2 ether}();

        // Try to withdraw more than max limit
        uint256 withdrawAmount = MAX_WITHDRAWAL + 0.1 ether;

        vm.prank(user1);
        vm.expectRevert("Withdrawal exceeds maximum limit");
        kipuBank.kipubank_withdraw(withdrawAmount);
    }

    // Test 7: Balance Query by Account Holder
    function testBalanceQueryByAccountHolder() public {
        uint256 depositAmount = 1 ether;

        vm.prank(user1);
        kipuBank.kipubank_deposit{value: depositAmount}();

        vm.prank(user1);
        uint256 balance = kipuBank.kipubank_getBalance(user1);
        assertEq(
            balance,
            depositAmount,
            "Balance query returned incorrect value"
        );
    }

    // Test 8: Balance Query by Owner
    function testBalanceQueryByOwner() public {
        uint256 depositAmount = 1 ether;

        vm.prank(user1);
        kipuBank.kipubank_deposit{value: depositAmount}();

        vm.prank(owner);
        uint256 balance = kipuBank.kipubank_getBalance(user1);
        assertEq(
            balance,
            depositAmount,
            "Owner balance query returned incorrect value"
        );
    }

    // Test 9: Balance Query by Unauthorized User
    function testBalanceQueryUnauthorized() public {
        uint256 depositAmount = 1 ether;

        vm.prank(user1);
        kipuBank.kipubank_deposit{value: depositAmount}();

        vm.prank(user2);
        vm.expectRevert("Only owner or account holder can view balance");
        kipuBank.kipubank_getBalance(user1);
    }

    // Test 10: Contract Balance
    function testContractBalance() public {
        uint256 depositAmount1 = 1 ether;
        uint256 depositAmount2 = 2 ether;

        vm.prank(user1);
        kipuBank.kipubank_deposit{value: depositAmount1}();

        vm.prank(user2);
        kipuBank.kipubank_deposit{value: depositAmount2}();

        assertEq(
            address(kipuBank).balance,
            depositAmount1 + depositAmount2,
            "Contract balance incorrect"
        );
    }
}
