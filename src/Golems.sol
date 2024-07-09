// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC1155 } from '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import { console } from 'forge-std/console.sol';

contract Golems is ERC1155 {
    enum Starters {
        STICK,
        EMBER,
        DROPLET
    }

    constructor() ERC1155('ipfs://QmURfC4rXTdhnQx8F8Ghq3jWHJbobrdkdevv5HcTyC2uts/{id}.json') {}

    function userMintStarter(Starters starter) public {
        _mint(msg.sender, uint256(starter), 1, '');
    }
}
