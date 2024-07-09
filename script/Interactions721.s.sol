// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from 'forge-std/Script.sol';
import { Golems721 } from 'src/Golems721.sol';
import { DevOpsTools } from 'foundry-devops/src/DevOpsTools.sol';

contract MintFireGolems721NFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mint721NFTOnContract(mostRecentlyDeployed);
    }

    function mint721NFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems721(contractAddress).mintFireNFT();
        vm.stopBroadcast();
    }
}

contract MintWaterGolems721NFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mint721NFTOnContract(mostRecentlyDeployed);
    }

    function mint721NFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems721(contractAddress).mintWaterNFT();
        vm.stopBroadcast();
    }
}

contract MintEarthGolems721NFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        mint721NFTOnContract(mostRecentlyDeployed);
    }

    function mint721NFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems721(contractAddress).mintEarthNFT();
        vm.stopBroadcast();
    }
}

contract Evolve721NFT is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('Golems', block.chainid);
        evolve721NFTOnContract(mostRecentlyDeployed);
    }

    function evolve721NFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        Golems721(contractAddress).evolveNFT(0);
        vm.stopBroadcast();
    }
}
