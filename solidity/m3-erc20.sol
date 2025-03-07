// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract AQNT is ERC20, AccessControl {
    bytes32 public constant MINTER = keccak256("MINTER");
    bytes32 public constant BURNER = keccak256("BURNER");
    bytes32 public constant ADMIN = keccak256("ADMIN");

    constructor() ERC20("AQuental Token", "AQNT") {
        _grantRole(ADMIN, msg.sender);
        _setRoleAdmin(MINTER, ADMIN);
        _setRoleAdmin(BURNER, ADMIN);
    }

    // Mint new tokens to a specified account
    function mint(address account, uint256 amount) public onlyRole(MINTER) {
        _mint(account, amount);
    }

    // Burn tokens from a specified account
    function burn(address account, uint256 amount) public onlyRole(BURNER) {
        _burn(account, amount);
    }

    // Add a new minter role to an account
    function addMinter(address account) public onlyRole(ADMIN) {
        _grantRole(MINTER, account);
    }

    // Remove minter role from an account
    function removeMinter(address account) public onlyRole(ADMIN) {
        _revokeRole(MINTER, account);
    }

    // Add a new burner role to an account
    function addBurner(address account) public onlyRole(ADMIN) {
        _grantRole(BURNER, account);
    }

    // Remove burner role from an account
    function removeBurner(address account) public onlyRole(ADMIN) {
        _revokeRole(BURNER, account);
    }
}
