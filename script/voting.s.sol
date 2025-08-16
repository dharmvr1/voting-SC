// SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {Voting} from "../src/voting.sol";

contract DeployVoting is Script {
    function run() external returns(Voting) {
          string[] memory proposals = new string[](3);
        proposals[0] = "dharm";
        proposals[1] = "raman";
        proposals[2] = "kirat";
        
        vm.startBroadcast();
      

        Voting voting = new Voting(proposals);
        vm.stopBroadcast();

        return voting;
    }
}
