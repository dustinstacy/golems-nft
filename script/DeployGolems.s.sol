// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Script } from 'forge-std/Script.sol';
import { Golems } from 'src/Golems.sol';

contract DeployGolems is Script {
    function run() external returns (Golems golems) {
        vm.startBroadcast();
        golems = new Golems(msg.sender);
        vm.stopBroadcast();
        return golems;
    }
}
