// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
// we will import an chainlink price feed oracle to do the job of giving us the price of eth
import {Priceconversion} from "./Priceconversion.sol";
error Fundme_NotOwner();
contract Fundme {
    using Priceconversion for uint256;
    //setting the owner variable while using immutable for gas efficencyth
    address public immutable i_owner;
    address public immutable i_OracleAddress;

    //We will set the minimum deposit here wich will be 100 usd while saving gas cost by using the const keyword
    // multiplying the value soo that it works with the eth decimals because its not possible to divide eth decimals becasue yiou will get a value les then wei
    uint256  constant MINIMUM_USD = 100e18;
    //setting the variable i will be using for the agrigator contract
    //setting the constructor to set what adress i will be using witht the agigator interface and also setting the owner to the msg.sender
    constructor(address oracleadress) {
        i_OracleAddress = oracleadress;
        i_owner = msg.sender;

    }

    // we will need to keep track of the balance of each one foe this i will use a mapping
    mapping (address => uint) private s_Balances;
    address[] private s_funders;

    //We will start by Setting a Fund function to recieve funds
    function Fund() public payable {
        //set the condition of atleast 100$
        require((msg.value).ConvertTo_USD(i_OracleAddress) >= MINIMUM_USD, "insuficient funds");
        s_funders.push(msg.sender);
        s_Balances[msg.sender] = msg.value;

    }
    // we will add a function that lets only the owner withraw funds using a modfifeir
    function withraw() public OnlyOwner payable {
        //reseting the mapping using a for loop that run trought the array
        address[] memory funders = s_funders;
        for (uint num = 0; num < s_funders.length; num++) 
        {
            s_Balances[funders[num]] = 0;
        }
        //reseting my array
        s_funders = new address[](0);
        // make the adress payable and use the transfer function to transfer all fund from the contract

        payable(msg.sender).transfer(address(this).balance);    

    }
    //we will add a modifier that specidy using a gas effecient error handling
    modifier OnlyOwner(){
        if (msg.sender != i_owner) {
            revert Fundme_NotOwner();
        }
        _;
    }
    function get_fundersarray(uint index)  public view returns (address) {
        return s_funders[index];
        
    }
    function get_fundersarraylength()  public view returns (uint) {
        return s_funders.length;
        
    }
    function get_balances(address theaddress)  public view returns (uint) {
        return s_Balances[theaddress];
        
    }
    receive() external payable  {
        Fund();
}
    fallback() external payable {
        Fund();
    }
    

}