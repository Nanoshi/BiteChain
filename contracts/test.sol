pragma solidity ^0.5.0;

contract Test {
    string string1;
    constructor() public {
        string1 = "foo";
    }
    function setString(string memory _input) public {
        string1 = _input;
    }
}