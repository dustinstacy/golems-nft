// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC1155 } from '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import { console } from 'forge-std/console.sol';

contract Golems is ERC1155 {
    error Golems__WhiteListPassesSoldOut();
    error Golems__MinimumDonationNotMet();
    error Golems__RequiresWhiteListPass();
    error Golems__InsufficientPeanutBalance();

    //********Token IDs *********//

    // Used as tokenIds 0, 1, 2
    enum Starters {
        STICK,
        EMBER,
        DROPLET
    }

    uint256 public constant PEANUTS = 100e10; // Starting tokenId, not the quantity
    uint256 public constant WHITE_LIST_PASS = 101e10;

    //*******State Variables ********//
    address owner;
    uint256 public constant MINIMUM_WHITE_LIST_DONATION = 0.05 ether;
    address[] public whiteListers;

    constructor(address _owner) ERC1155('ipfs://QmURfC4rXTdhnQx8F8Ghq3jWHJbobrdkdevv5HcTyC2uts/{id}.json') {
        owner = _owner;
    }

    function joinWhiteList() public payable {
        if (whiteListers.length == 100) {
            revert Golems__WhiteListPassesSoldOut();
        }
        if (msg.value < MINIMUM_WHITE_LIST_DONATION) {
            revert Golems__MinimumDonationNotMet();
        }
        whiteListers.push(msg.sender);
        _mint(msg.sender, WHITE_LIST_PASS, 1, '');
    }

    function claimWhiteListGift() public {
        if (balanceOf(msg.sender, WHITE_LIST_PASS) == 0) {
            revert Golems__RequiresWhiteListPass();
        }
        _mint(msg.sender, PEANUTS, 1000, '');
    }

    function mintStarter(Starters starter) public {
        if (balanceOf(msg.sender, PEANUTS) < 10) {
            revert Golems__InsufficientPeanutBalance();
        }
        safeTransferFrom(msg.sender, owner, PEANUTS, 10, '');
        _mint(msg.sender, uint256(starter), 1, '');
    }

    function evolveNFT(uint256 tokenId) public {
        if (balanceOf(msg.sender, PEANUTS) < 50) {
            revert Golems__InsufficientPeanutBalance();
        }
        _burn(msg.sender, tokenId, 1);
        _mint(msg.sender, (tokenId + 3), 1, '');
    }
}
