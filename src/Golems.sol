// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import { ERC721URIStorage } from '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';

contract Golems is ERC721, ERC721URIStorage {
    uint256 private tokenCounter;
    string public constant FIRE_STARTER = 'fireGolem1.json';
    string public constant WATER_STARTER = 'waterGolem1.json';
    string public constant EARTH_STARTER = 'earthGolem1.json';

    constructor() ERC721('Googly Golems', 'GOG') {
        tokenCounter = 0;
    }

    function mintNFT() public {
        if (tokenCounter % 3 == 0) {
            _setTokenURI(tokenCounter, FIRE_STARTER);
        } else if (tokenCounter % 3 == 1) {
            _setTokenURI(tokenCounter, WATER_STARTER);
        } else {
            _setTokenURI(tokenCounter, EARTH_STARTER);
        }
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function evolveNFT(uint256 tokenId) public {}

    function _baseURI() internal pure override returns (string memory) {
        return 'ipfs://bafybeifilwtixo2thptgtke2e6qzxtgfeivlc6vywwsro3kupe4potmpwa/';
    }

    // The following functions are overrides required by Solidity

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
