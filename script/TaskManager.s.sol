// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {TaskManager} from "../src/TaskManager.sol";

contract TaskManagerScript is Script {
    TaskManager public task_manager;

    function run() public returns (TaskManager) {
        vm.startBroadcast();

        task_manager = new TaskManager();

        vm.stopBroadcast();
        return task_manager;
    }
}
