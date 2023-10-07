// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {Fundme} from "../src/Fundme.sol";
import {Networkconfig} from "../script/Networkconfig.s.sol";
contract Deploy is Script {
   function run() external returns (Fundme){
    vm.startBroadcast();
    Networkconfig networkconfig = new Networkconfig();
    Fundme fundme = new Fundme(networkconfig.GetOracleLink());
    vm.stopBroadcast();
    return fundme;
    
   }
}