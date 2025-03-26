// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// As multiple user can have multiple task so We will not be using Ownable from openzeppline because
// different Task may have different owners.
contract TaskManager {
    struct Task {
        uint256 id;
        string title;
        string description;
        bool completed;
        address owner;
    }
    //As multiple user will have multiple task so we'll be using mapping of address and task array.
    //Index of Task array can be considered as taskId(i.e Index+1 , starts from 1)

    mapping(address => Task[]) private tasks;

    event TaskCreated(address indexed user, uint256 taskId, string title);
    event TaskCompleted(address indexed user, uint256 taskId);
    event TaskEdited(address indexed user, uint256 taskId, string newTitle, string newDescription);
    event TaskDeleted(address indexed user, uint256 taskId);

    modifier onlyTaskOwner(uint256 _id) {
        require(_id > 0 && _id <= tasks[msg.sender].length, "Invalid Task Id");
        require(tasks[msg.sender][_id - 1].owner == msg.sender, "You are not owner of task");
        _;
    }

    function createNewTask(string memory _title, string memory _description) public {
        require(bytes(_title).length > 0, "Empty title");
        uint256 task_id = tasks[msg.sender].length + 1;
        Task memory task = Task(task_id, _title, _description, false, msg.sender);
        tasks[msg.sender].push(task);
        emit TaskCreated(msg.sender, task_id, _title);
    }

    function completeTask(uint256 _id) public onlyTaskOwner(_id) {
        tasks[msg.sender][_id - 1].completed = !tasks[msg.sender][_id - 1].completed;
        emit TaskCompleted(msg.sender, _id);
    }

    function editTask(uint256 _id, string memory newTitle, string memory newDescription) public onlyTaskOwner(_id) {
        require(bytes(newTitle).length > 0, "Empty title");
        tasks[msg.sender][_id - 1].title = newTitle;
        tasks[msg.sender][_id - 1].description = newDescription;
        emit TaskEdited(msg.sender, _id, newTitle, newDescription);
    }

    function deleteTask(uint256 _id) public onlyTaskOwner(_id) {
        for (uint256 i = _id - 1; i < tasks[msg.sender].length - 1; i++) {
            tasks[msg.sender][i] = tasks[msg.sender][i + 1];
        }
        tasks[msg.sender].pop();
        emit TaskDeleted(msg.sender, _id);
    }

    function getTask(uint256 _id) public view onlyTaskOwner(_id) returns (string memory, string memory, bool) {
        return (
            tasks[msg.sender][_id - 1].title,
            tasks[msg.sender][_id - 1].description,
            tasks[msg.sender][_id - 1].completed
        );
    }

    function getAllTask() public view returns (Task[] memory) {
        return tasks[msg.sender];
    }
}
