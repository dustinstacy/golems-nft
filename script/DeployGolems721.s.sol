// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from 'forge-std/Script.sol';
import { Golems721 } from 'src/Golems721.sol';

contract DeployGolems721 is Script {
    function run() external returns (Golems721 golems721) {
        vm.startBroadcast();
        golems721 = new Golems721();
        vm.stopBroadcast();
        return golems721;
    }
}
