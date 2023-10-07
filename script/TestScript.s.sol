// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {Fundme} from "../src/Fundme.sol";
import {Networkconfig} from "../script/Networkconfig.s.sol";
import {MockV3Aggregator} from "../script/Mockcontract.sol";
import {Networkconfig} from "../script/Networkconfig.s.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract Deployran is Script {
   function run()  public returns (int) {
      vm.startBroadcast();
   /* MockV3Aggregator mock = new MockV3Aggregator(18, 2000);
   //declaring our contract with its adress but this time inside a function*/
        AggregatorV3Interface dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        (,int price,,,) = dataFeed.latestRoundData();
        //we add the decimal places so that it matches eth
    vm.stopBroadcast();
    return price;
   }
   
  
}