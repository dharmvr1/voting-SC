// SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;

contract Voting {
    struct voter {
        bool hasVoted;
        uint choice;
    }
    struct Proposal {
        string Name;
        uint VoteCounted;
    }

    address public ChairPerson;

    mapping(address => voter) public Voters;

    Proposal[] public proposals;

    constructor(string[] memory proposalNames) {
        ChairPerson = msg.sender;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({Name: proposalNames[i], VoteCounted: 0}));
        }
    }

    function giveRightToVote(address voterPerson) external {
        require(msg.sender == ChairPerson, "not chairPerson");
        require(Voters[voterPerson].hasVoted == false, "person already voted");
        Voters[voterPerson].choice = 0;
        Voters[voterPerson].hasVoted = false;
    }

    function vote(uint proposalIndex) external {
        voter storage sender = Voters[msg.sender];

        require(sender.hasVoted == false, "you already voted");
        require(proposalIndex < proposals.length, "proposal not exist");
        sender.choice = proposalIndex;
        sender.hasVoted = true;
        proposals[proposalIndex].VoteCounted += 1;
    }

    function winingProposal() public view returns (uint) {
        uint highestVotes = 0;
        uint winnerIndex;
        for (uint i = 0; i <= proposals.length; i++) {
            if (proposals[i].VoteCounted > highestVotes) {
                highestVotes = proposals[i].VoteCounted;
                winnerIndex = i;
            }
        }

        return winnerIndex;
    }

    function winnerNames() external view returns (string memory) {
        return proposals[winingProposal()].Name;
    }
}
