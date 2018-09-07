pragma solidity ^0.4.23;
contract Project{
	mapping (bytes32=>HashStruct) query;
	//the address of the administrator
	address private owner=0xaA97467bB87D1512dff5c3B69AF9A3E0274fcF20;

	struct HashStruct{
            bytes32[] arrayofhash;
	    mapping (bytes32=>uint256) timestamps;
	    mapping (bytes32=>uint256) timestampsEnd;
	    mapping (bytes32=>uint256) timeKey;
	}
    
	function addValue(bytes32 _queryhash,bytes32 _answerhash,uint256 _timekey)public{
	    //only the administrator can add new values
	    require(msg.sender==owner);
	    //don't add the same answer
            require(query[_queryhash].timestamps[_answerhash]==0);
	    //check if the query is new
            if(query[_queryhash].arrayofhash.length>0){
                bytes32 last_answer = query[_queryhash].arrayofhash[query[_queryhash].arrayofhash.length-1];
                query[_queryhash].timestampsEnd[last_answer]=now;
            }
	    query[_queryhash].arrayofhash.push(_answerhash);
	    query[_queryhash].timestamps[_answerhash]=now;
	    query[_queryhash].timeKey[_answerhash]=_timekey;
	}
	
	
	// Returns zero if the hash of the query does not exist 
	function returnLatest(bytes32 _queryhash)view public returns(bytes32){
	    if(query[_queryhash].arrayofhash.length==0)
	    {
	        return 0;
	    }
	    return query[_queryhash].arrayofhash[query[_queryhash].arrayofhash.length-1];
	}
	
	function returntime(bytes32 _queryhash,bytes32 _answerhash)view public returns(uint256 _from, uint256 _since){	    
	    return (query[_queryhash].timestamps[_answerhash],query[_queryhash].timestampsEnd[_answerhash]);
	}
	
	function getAll(bytes32 _queryhash,uint256 _cursor,uint256 _amount)view public returns(bytes32[] values){
	    uint256 length = _amount;
            if (length > query[_queryhash].arrayofhash.length - _cursor) {
            length = query[_queryhash].arrayofhash.length - _cursor;
        }
            values = new bytes32[](length);
            for (uint256 i = 0; i < length; i++) {
                values[i] = query[_queryhash].arrayofhash[_cursor + i];
            }
	    return values;
	}
	
	function getLength(bytes32 _queryhash)view public returns(uint256){
	    return query[_queryhash].arrayofhash.length;
	}
	
	function getTimekey(bytes32 _queryhash)view public returns(uint256){
	    require(query[_queryhash].arrayofhash.length>0);
	    return query[_queryhash].timeKey[query[_queryhash].arrayofhash[query[_queryhash].arrayofhash.length-1]];
	}
}

