// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {TaskManager} from "../src/TaskManager.sol";
import {TaskManagerScript} from "../script/TaskManager.s.sol";

contract TaskManagerTest is Test {
    TaskManager public task_manager;

    address user1 = address(0x123);
    address user2 = address(0x456);

    function setUp() public {
        //Testing of deployement of TaskManager contract
        TaskManagerScript script = new TaskManagerScript();
        task_manager = script.run();
    }
    //Checking whether task is created or not , Also checking whether each user have it's own task array or not.
    function test_createTask() public {
        vm.prank(user1);
        task_manager.createNewTask("Task1 of user1", "Testing Task1");
        vm.prank(user1);
        (string memory title, string memory description, bool completed) = task_manager.getTask(1);
        assertEq(title, "Task1 of user1");
        assertEq(description, "Testing Task1");
        assertEq(completed, false);
        //Checking whether user2 have it's own task array or not.
        vm.prank(user2);
        task_manager.createNewTask("Task1 of user2", "Testing Task1");
        vm.prank(user2);
        (title, description, completed) = task_manager.getTask(1);
        assertEq(title, "Task1 of user2");
        assertEq(description, "Testing Task1");
        assertEq(completed, false);
    }

    function test_TaskComplete() public {
        vm.prank(user1);
        task_manager.createNewTask("Test Task of user1", "To be completed");
        vm.prank(user1);
        task_manager.completeTask(1);
        vm.prank(user1);
        (, , bool completed) = task_manager.getTask(1);
        assertEq(completed, true);
    }

    function test_TaskEdit() public {
        vm.prank(user1);
        task_manager.createNewTask("Task1 of user1", "Testing Task1");
        vm.prank(user1);
        task_manager.editTask(1, "Task1 of user1 edited", "Testing Task1 edited");
        vm.prank(user1);
        (string memory title, string memory description, bool completed) = task_manager.getTask(1);
        assertEq(title, "Task1 of user1 edited");
        assertEq(description, "Testing Task1 edited");
        assertEq(completed, false);
    }

    function test_DeleteTask() public {
        vm.prank(user1);
        task_manager.createNewTask("Task1 of user1","Testing Task1");
        vm.prank(user1);
        task_manager.createNewTask("Task2 of user1","Testing Task2");
        vm.prank(user1);
        task_manager.deleteTask(1);
        vm.prank(user1);
        (string memory title, string memory description, bool completed) = task_manager.getTask(1);
        assertEq(title, "Task2 of user1");
        assertEq(description, "Testing Task2");
        assertEq(completed, false);
        vm.prank(user1);
        task_manager.deleteTask(1);
        vm.expectRevert("Invalid Task Id");
        vm.prank(user1);
        task_manager.getTask(1);
    }

    function test_Access() public{
        vm.prank(user1);
        task_manager.createNewTask("Task1 of user1","Testing Task1");
        vm.expectRevert("Invalid Task Id");
        vm.prank(user2);
        task_manager.completeTask(1);
        vm.expectRevert("Invalid Task Id");
        vm.prank(user2);
        task_manager.editTask(1,"Task1 of user1 edited","Testing Task1 edited");
        vm.expectRevert("Invalid Task Id");
        vm.prank(user2);
        task_manager.deleteTask(1);
        vm.expectRevert("Invalid Task Id");
        vm.prank(user2);
        task_manager.getTask(1);
    }

    function test_invalid_id() public{
        vm.expectRevert("Invalid Task Id");
        vm.prank(user1);
        task_manager.deleteTask(0);
    }

    function test_empty_title() public{
        vm.expectRevert("Empty title");
        vm.prank(user1);
        task_manager.createNewTask("","Testing Task1");
    }

    function test_getAllTask() public{
        vm.prank(user1);
        task_manager.createNewTask("Task1 of user1","Testing Task1");
        vm.prank(user1);
        task_manager.createNewTask("Task2 of user1","Testing Task2");
        vm.prank(user1);
        task_manager.createNewTask("Task3 of user1","Testing Task3");
        vm.prank(user1);
        TaskManager.Task[] memory task = task_manager.getAllTask();
        assertEq(task.length,3);
        assertEq(task[0].id,1);
        assertEq(task[1].id,2);
        assertEq(task[2].id,3);
    }

}
