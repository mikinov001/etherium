// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 private _currentTokenId;

    // Event to log each token minted
    event TokenMinted(address indexed owner, uint256 indexed tokenId);

    /**
     * @dev Constructor function
     */
    constructor() ERC721("MyNFT", "MNFT") {
        _currentTokenId = 0;
    }

    /**
     * @dev Function to mint new NFTs
     * @param recipient The address to which the new NFT will be minted
     * @return The token ID of the newly minted NFT
     */
    function mint(address recipient) external onlyOwner returns (uint256) {
        _currentTokenId++;
        _safeMint(recipient, _currentTokenId);
        emit TokenMinted(recipient, _currentTokenId);
        return _currentTokenId;
    }

    /**
     * @dev Function to burn existing NFTs
     * @param tokenId The ID of the NFT to burn
     */
    function burn(uint256 tokenId) external onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        _burn(tokenId);
    }

    /**
     * @dev Function to get the total number of tokens minted
     * @return The total number of tokens minted
     */
    function totalSupply() external view returns (uint256) {
        return _currentTokenId;
    }
}
