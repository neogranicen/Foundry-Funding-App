// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {MockV3Aggregator} from  "./Mockcontract.sol";

contract Networkconfig  {
   function GetOracleLink() public  returns (address) {
      if (block.chainid == 1) {
         return ReturnEthMainenetChainlinkOracale();
      } else if (block.chainid == 11155111) {
         return ReturnSepoliaChainlinkOracale();

      }
      else {
         return ReturnAnvilOracale();
      }
   }
   function ReturnSepoliaChainlinkOracale() public pure returns (address)  {
      address SepoliaOracaleLink = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
      return SepoliaOracaleLink ;
   }
   function ReturnEthMainenetChainlinkOracale() public pure returns (address) {
   address EthMainenetOracaleLink = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
      return EthMainenetOracaleLink ;
   }
   function ReturnAnvilOracale() public returns (address)  { 
      MockV3Aggregator aggregator = new MockV3Aggregator(18 , 200000000000);
      return address(aggregator);
      
   }

}