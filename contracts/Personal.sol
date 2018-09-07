pragma solidity ^0.4.23;
contract Personal{
    bytes32 hashValue;

    constructor(bytes32 _hashValue) public{
        hashValue=_hashValue;        
    }
    
    function getdata()view public returns(bytes32 _data){
        return hashValue;    
    }
}

