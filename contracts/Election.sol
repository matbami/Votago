
pragma solidity ^0.5.0;

contract Election {
    // Read/write candidate
   struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Read/write Candidates
    mapping(uint => Candidate) public candidates;

     mapping(address => bool) public voters;

     // Store Candidates Count
    uint public candidatesCount;

event votedEvent(
    uint indexed _candidateId
);
    // Constructor
    string public name;
     uint public voteEnd;
    constructor() public{
       name = "Election101";
        // uint public voteEnd;
        voteEnd = now  * 2 minutes;
       addCandidate("Candidate 1");
        addCandidate("Candidate 2"); 
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
       require(now < voteEnd);
        //require that they haven't voted before
        require(!voters[msg.sender]); 

        //require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        //trigger voted event
       emit votedEvent(_candidateId);
    }

}