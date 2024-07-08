// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from 'forge-std/Script.sol';
import { Golems } from 'src/Golems.sol';
import { DevOpsTools } from 'foundry-devops/src/DevOpsTools.sol';

contract MintGolemsNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems(contractAddress).mintNFT();
        vm.stopBroadcast();
    }
}
