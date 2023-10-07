// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
// creating a library to do all the qualqulations from eth to usd soo that i organize 
// we will import the chainlink oracle and declarfe the library
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {Fundme} from "./Fundme.sol";
library Priceconversion {
    // will copy and paste the code here 
    //we are going to use this function to get the latest price from the oracle later we will call it inside the conversion function to get the lastest price
    //setting it to view will be a good thing i think
    
    function Latest_Price(address oracleadress) public view returns (int) {
        //declaring our contract with its adress but this time inside a function
        AggregatorV3Interface dataFeed = AggregatorV3Interface( oracleadress);

        (,int price,,,) = dataFeed.latestRoundData();
        //we add the decimal places so that it matches eth
        return price*10**10;
    }
    //Do the conversion on the eth to get usd
    function ConvertTo_USD(uint ethamount, address oracleadress) public view returns  (uint) {
        // we keep it in form of of E18 soo that no smalll number of funds is lost but its possible to convert it to dollar and not add e 18 to the checking
       return (ethamount) * uint(Latest_Price(oracleadress)) / 10**18 ;

    }
}