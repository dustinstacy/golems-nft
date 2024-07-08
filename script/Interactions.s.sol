// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from 'forge-std/Script.sol';
import { Golems } from 'src/Golems.sol';

contract MintGolemsNFT is Script {
    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems(contractAddress).mintNFT();
        vm.stopBroadcast();
    }
}
