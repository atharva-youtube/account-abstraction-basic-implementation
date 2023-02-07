// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dummy {
    uint256 public counter;

    constructor() {
        counter = 0;
    }

    function increment() public {
        counter += 1;
    }
}