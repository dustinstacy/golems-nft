// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import { ERC721URIStorage } from '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import { console } from 'forge-std/console.sol';

contract Golems721 is ERC721, ERC721URIStorage {
    error Golems721__NoFireGolemsLeft();
    error Golems721__NoWaterGolemsLeft();
    error Golems721__NoEarthGolemsLeft();
    error Golems721__YourNFTIsAtMaxLevel();
    error Golems721__YouAlreadyHaveAStarter();

    uint256 private fireTokenCounter;
    uint256 private waterTokenCounter;
    uint256 private earthTokenCounter;
    string public constant FIRE_STARTER = 'fireGolem1.json';
    string public constant WATER_STARTER = 'waterGolem1.json';
    string public constant EARTH_STARTER = 'earthGolem1.json';

    enum Level {
        ONE,
        TWO,
        THREE
    }

    struct Owner {
        bool hasStarter;
        uint256 tokenId;
    }

    mapping(uint256 tokenId => Level) private tokenIdLevel;
    mapping(uint256 tokenId => string element) private tokenIdElement;
    mapping(address => Owner) private ownerStatus;

    modifier checkIfHasStarter(address sender) {
        if (ownerStatus[sender].hasStarter == true) {
            revert Golems721__YouAlreadyHaveAStarter();
        }
        _;
    }

    constructor() ERC721('Googly Golems', 'GOG') {
        fireTokenCounter = 0;
        waterTokenCounter = 10;
        earthTokenCounter = 20;
    }

    function mintFireNFT() public checkIfHasStarter(msg.sender) {
        if (fireTokenCounter > 9) {
            revert Golems721__NoFireGolemsLeft();
        }
        tokenIdElement[fireTokenCounter] = 'fire';
        _setTokenURI(fireTokenCounter, FIRE_STARTER);
        _safeMint(msg.sender, fireTokenCounter);
        ownerStatus[msg.sender].hasStarter = true;
        ownerStatus[msg.sender].tokenId = fireTokenCounter;
        fireTokenCounter++;
    }

    function mintWaterNFT() public checkIfHasStarter(msg.sender) {
        if (waterTokenCounter > 19) {
            revert Golems721__NoWaterGolemsLeft();
        }
        tokenIdElement[waterTokenCounter] = 'water';
        _setTokenURI(waterTokenCounter, WATER_STARTER);
        _safeMint(msg.sender, waterTokenCounter);
        ownerStatus[msg.sender].hasStarter = true;
        ownerStatus[msg.sender].tokenId = waterTokenCounter;
        waterTokenCounter++;
    }

    function mintEarthNFT() public checkIfHasStarter(msg.sender) {
        if (earthTokenCounter > 29) {
            revert Golems721__NoEarthGolemsLeft();
        }
        tokenIdElement[earthTokenCounter] = 'earth';
        _setTokenURI(earthTokenCounter, EARTH_STARTER);
        _safeMint(msg.sender, earthTokenCounter);
        ownerStatus[msg.sender].hasStarter = true;
        ownerStatus[msg.sender].tokenId = earthTokenCounter;
        earthTokenCounter++;
    }

    function evolveNFT(uint256 tokenId) public {
        if (tokenIdLevel[tokenId] == Level.THREE) {
            revert Golems721__YourNFTIsAtMaxLevel();
        }
        string memory element = tokenIdElement[tokenId];
        if (tokenIdLevel[tokenId] == Level.ONE) {
            string memory newURI = string.concat(element, 'Golem2.json');
            _setTokenURI(tokenId, newURI);
            tokenIdLevel[tokenId] = Level.TWO;
            ownerStatus[msg.sender].hasStarter = false;
        } else if (tokenIdLevel[tokenId] == Level.TWO) {
            string memory newURI = string.concat(element, 'Golem3.json');
            _setTokenURI(tokenId, newURI);
            tokenIdLevel[tokenId] = Level.THREE;
        }
    }

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

    function getTokenIdByOwner(address owner) public view returns (uint256) {
        return ownerStatus[owner].tokenId;
    }
}
