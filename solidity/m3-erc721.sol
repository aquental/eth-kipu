// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AQNTNFT is ERC721, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    bytes32 public constant MINTER = keccak256("MINTER");
    bytes32 public constant BURNER = keccak256("BURNER");
    bytes32 public constant ADMIN = keccak256("ADMIN");

    constructor() ERC721("AQuental NFT", "AQNT") {
        _grantRole(ADMIN, msg.sender);
        _setRoleAdmin(MINTER, ADMIN);
        _setRoleAdmin(BURNER, ADMIN);
    }

    // Mint a new NFT to a specified account
    function mint(address to) public onlyRole(MINTER) returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        return tokenId;
    }

    // Burn an existing NFT by token ID
    function burn(uint256 tokenId) public onlyRole(BURNER) {
        _burn(tokenId);
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

    // Override to support AccessControl interface
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
