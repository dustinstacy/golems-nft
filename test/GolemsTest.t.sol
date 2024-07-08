// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console } from 'forge-std/Test.sol';
import { Golems } from 'src/Golems.sol';

contract GolemsTest is Test {
    Golems golems;

    address USER = makeAddr('user');

    function setUp() public {
        golems = new Golems();
    }

    function testTokenURI() public {
        vm.prank(USER);
        golems.mintNFT();
        console.log(golems.tokenURI(0));
    }
}
