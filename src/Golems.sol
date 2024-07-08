// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract Golems is ERC721 {
    uint256 private tokenCounter;

    constructor() ERC721('Googly Golems', 'GOG') {
        tokenCounter = 0;
    }

    function mintNFT() public {
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function evolveNFT() public {}

    function _baseURI() internal pure override returns (string memory) {
        return 'ipfs://bafybeifilwtixo2thptgtke2e6qzxtgfeivlc6vywwsro3kupe4potmpwa/';
    }

    function tokenURI(uint256 /* tokenID */) public pure override returns (string memory) {
        return string(abi.encodePacked(_baseURI(), 'fireGolem1.json'));
    }
}
