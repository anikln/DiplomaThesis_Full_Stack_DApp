pragma solidity ^0.4.23;

import "./Personal.sol";

contract Factoryproject {
   address private owner=0xaA97467bB87D1512dff5c3B69AF9A3E0274fcF20;
   address[] public addresses_contracts;
   mapping (address => bool) addressExist;

   event LogNewContract(address newContract);

   function createContract(bytes32 _data) public{
	require(msg.sender==owner);
        address c = new Personal(_data);
	addresses_contracts.push(c); 
        addressExist[c] = true;
	emit LogNewContract(c);
   }
   
   function getData(address _contract) view public returns(bytes32 specificdata){
	if(addressExist[_contract]==false){
            return 0;
        }else{
	    return (Personal(_contract).getdata());
        }
   }
}

