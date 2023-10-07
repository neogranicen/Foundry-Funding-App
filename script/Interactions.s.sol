// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {Fundme} from "../src/Fundme.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
contract Fund is Script {
    uint public value_to_send = 0.33 ether;
    function fundme_fund(address contractAddress) public {
        vm.startBroadcast();
        Fundme fundme = Fundme(payable(contractAddress));
        fundme.Fund{value: value_to_send}();
        vm.stopBroadcast();
    }
    function run() external {

        address contractAddress = DevOpsTools.get_most_recent_deployment("Fundme", block.chainid);
        fundme_fund(contractAddress);

    
    }
}
contract Winthraw is Script {
    
    function fundme_Winthraw(address contractAddress) public {
        vm.startBroadcast();
        Fundme fundme = Fundme(payable(contractAddress));
        fundme.withraw();
        vm.stopBroadcast();
        
    }
    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment("Fundme", block.chainid);
        fundme_Winthraw(contractAddress);
    }
}