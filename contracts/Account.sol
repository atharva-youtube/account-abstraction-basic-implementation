// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Account {
    string public name;
    address public owner;
    address public backupAccount;

    constructor(address _backupAccount, string memory _name) {
        owner = msg.sender;
        backupAccount = _backupAccount;
        name = _name;
    }

    function withdraw() public {
        require(owner == msg.sender, "!Auth");
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success, "Failed");
    }

    function call(address _contractAddress, bytes memory _data) public payable {
        require(owner == msg.sender, "!Auth");
        (bool success,) = _contractAddress.call{value: msg.value}(_data);
        require(success, "Failed");
    }

    function claimOwnership(address _newBackupAccount) public {
        require(backupAccount == msg.sender, '!BackupAcc');
        owner = msg.sender;
        backupAccount = _newBackupAccount;
    }

    function changeBackupAccount(address _newBackupAccount) public {
        require(owner == msg.sender, "!Auth");
        backupAccount = _newBackupAccount;
    }
}