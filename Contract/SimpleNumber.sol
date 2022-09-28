// SPDX-License-Identifier: MIT    
// The version of the Solidity language to use
pragma solidity ^0.8.0;
contract SimpleNumber{
    uint internal storedNumber;

    function getStoredNumber() public view returns(uint){
    return storedNumber;
     }

    function updateStoredNumber(uint newValue) public returns(uint){
        storedNumber=newValue;

        return storedNumber;
    }
}
