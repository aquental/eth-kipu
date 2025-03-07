// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AQuentalNFT is ERC721, ERC721Burnable, AccessControl {
    using Counters for Counters.Counter;

    // Define roles
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    // Token ID counter
    Counters.Counter private _tokenIdCounter;

    constructor(address admin) ERC721("AQuental NFT", "AQNT") {
        // Grant the contract deployer the ADMIN role
        _grantRole(ADMIN_ROLE, admin);
    }

    /**
     * @dev Mints a new token.
     * Only accounts with the MINTER_ROLE can mint new tokens.
     * @param to The address to receive the minted token.
     */
    function mint(address to) external onlyRole(MINTER_ROLE) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
    }

    /**
     * @dev Burns an existing token.
     * Only accounts with the BURNER_ROLE can burn tokens.
     * @param tokenId The ID of the token to burn.
     */
    function burn(uint256 tokenId) public override onlyRole(BURNER_ROLE) {
        super.burn(tokenId);
    }

    /**
     * @dev Grants the MINTER role to an address.
     * Only the ADMIN can call this function.
     * @param account The address to grant MINTER_ROLE.
     */
    function grantMinterRole(address account) external onlyRole(ADMIN_ROLE) {
        _grantRole(MINTER_ROLE, account);
    }

    /**
     * @dev Grants the BURNER role to an address.
     * Only the ADMIN can call this function.
     * @param account The address to grant BURNER_ROLE.
     */
    function grantBurnerRole(address account) external onlyRole(ADMIN_ROLE) {
        _grantRole(BURNER_ROLE, account);
    }

    /**
     * @dev Revokes the MINTER role from an address.
     * Only the ADMIN can call this function.
     * @param account The address to revoke MINTER_ROLE.
     */
    function revokeMinterRole(address account) external onlyRole(ADMIN_ROLE) {
        _revokeRole(MINTER_ROLE, account);
    }

    /**
     * @dev Revokes the BURNER role from an address.
     * Only the ADMIN can call this function.
     * @param account The address to revoke BURNER_ROLE.
     */
    function revokeBurnerRole(address account) external onlyRole(ADMIN_ROLE) {
        _revokeRole(BURNER_ROLE, account);
    }

    /**
     * @dev Transfers the ADMIN role to a new address.
     * Only the current ADMIN can call this function.
     * @param newAdmin The address to receive ADMIN_ROLE.
     */
    function transferAdminRole(address newAdmin) external onlyRole(ADMIN_ROLE) {
        require(newAdmin != address(0), "New admin cannot be zero address");
        _grantRole(ADMIN_ROLE, newAdmin);
        _revokeRole(ADMIN_ROLE, _msgSender());
    }

    /**
     * @dev Overriding supportsInterface due to multiple inheritance.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
