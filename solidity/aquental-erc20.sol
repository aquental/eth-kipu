// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact antonio.quental@gmail.com
contract AQuental is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    // Defines the AQuental contract inheriting from multiple OpenZeppelin contracts:
    // ERC20: Basic token functionality
    // ERC20Burnable: Ability to burn tokens
    // Ownable: Ownership and access control
    // ERC20Permit: Permit functionality for gasless approvals
    constructor(
        address initialOwner
    )
        // Constructor takes initial owner address as parameter
        ERC20("AQuental", "QNT") // Initializes ERC20 with name "AQuental" and symbol "QNT"
        Ownable(initialOwner) // Sets the initial owner through Ownable constructor
        ERC20Permit("AQuental") // Initializes permit functionality with token name
    {
        _mint(msg.sender, 10 * 10 ** decimals());
        // Mints initial supply of 10 tokens (adjusted by decimals) to the deployer
        // decimals() is inherited from ERC20 and typically returns 18
        // So this creates 10 * 10^18 = 10 quintillion wei units
    }

    function mint(address to, uint256 amount) public onlyOwner {
        // Public function to mint new tokens
        // onlyOwner modifier restricts access to contract owner only
        // Parameters:
        // - to: address that will receive the newly minted tokens
        // - amount: number of tokens to mint (in wei units)
        _mint(to, amount); // Internal ERC20 function to create new tokens
    }
}
