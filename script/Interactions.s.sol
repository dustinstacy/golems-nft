// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from 'forge-std/Script.sol';
import { Golems } from 'src/Golems.sol';
import { DevOpsTools } from 'foundry-devops/src/DevOpsTools.sol';

contract MintFireGolemsNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems(contractAddress).mintFireNFT();
        vm.stopBroadcast();
    }
}

contract MintWaterGolemsNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems(contractAddress).mintWaterNFT();
        vm.stopBroadcast();
    }
}

contract MintEarthGolemsNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems(contractAddress).mintEarthNFT();
        vm.stopBroadcast();
    }
}

contract EvolveNFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        evolveNFTOnContract(mostRecentlyDeployed);
    }

    function evolveNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems(contractAddress).evolveNFT(0);
        vm.stopBroadcast();
    }
}
