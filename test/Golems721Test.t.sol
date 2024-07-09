// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from 'forge-std/Test.sol';
import { Golems721 } from 'src/Golems721.sol';

contract Golems721Test is Test {
    Golems721 golems721;

    address USER = makeAddr('user');

    function setUp() public {
        golems721 = new Golems721();
    }

    function testURI() public {
        vm.prank(USER);
        golems721.mintFireNFT();
        vm.prank(USER);
        golems721.evolveNFT(0);
        console.log(golems721.tokenURI(0));
    }
}
