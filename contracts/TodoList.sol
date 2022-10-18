// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract TodoList {
  uint public taskCount;
  constructor() public {
    taskCount = 0;
  }

  struct Task {
    uint id;
    string name;
    string aadhaar;
    string pan;
    string bank;
    string ifsc;
//    string branch;
//    string _address;
    string phone;
    string doctor;
    string city;
    string pincode;
    uint age;
    uint amount;
  }
  Task[] private todos;

  event TaskAdded(uint taskCount, string name, string aadhaar, string pan, string bank, string ifsc, string phone, string doctor, string city, string pincode, uint age, uint amount);
  event DeleteTask(uint id);
  event MarkDone(uint id);
  event addMultiples(Task[] details);

  function getTaskCount() public view returns(uint) {
    return taskCount;
  }
  function addTask(string memory name, string memory aadhaar, string memory pan, string memory bank, string memory ifsc, string memory phone, string memory doctor, string memory city, string memory pincode, uint age, uint amount) public {
    ++taskCount;
    Task memory task = Task(taskCount, name, aadhaar, pan, bank, ifsc, phone, doctor, city, pincode, age, amount);
    todos.push(task);
    emit TaskAdded(taskCount, name, aadhaar, pan, bank, ifsc, phone, doctor, city, pincode, age, amount);
  }

  function deleteTask(uint _id) public {
    if(_id > taskCount) return;

    for(uint i = _id - 1; i < taskCount - 1; ++i) {
      todos[i] = todos[i + 1];
    }
    todos.pop();
    taskCount -= 1;
    emit DeleteTask(_id);
  }

  function markDone(uint _id) public {
    require(_id <= taskCount);
//    todos[_id - 1].completed = true;
    emit MarkDone(_id);
  }

  function getTask(uint _id) public view returns(Task memory) {
    return todos[_id - 1];
  }

  function addMultiple(Task[] memory details) public {
    for(uint i = 0; i < details.length; ++i) {
      ++taskCount;
      todos.push(details[i]);
    }
    emit addMultiples(details);
  }
}
