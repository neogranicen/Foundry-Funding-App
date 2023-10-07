// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Deploy} from "../script/Deploy.s.sol";
import {Fundme} from "../src/Fundme.sol";
import {StdCheats} from "../lib/forge-std/src/StdCheats.sol";
import {Fund, Winthraw} from "../script/Interactions.s.sol";
contract FundmeInteractionTest is StdCheats , Test{
    Fundme public fundme;
    address public user;
    Fund public fund;
    Winthraw public winthraw;

    
function setUp() external {
    Deploy deploy = new Deploy();
    fundme = deploy.run();
    fund = new Fund();
    winthraw = new Winthraw();
     user = makeAddr("Neo");
}
modifier DepositFromARanomUser {
    // hoax(user,10 ether); this is the same as the 2 above
    fund.fundme_fund(address(fundme));
    _;
}
modifier OwnerWinthrawAtTheEnd {
    _;
    vm.startPrank(fundme.i_owner());
    winthraw.fundme_Winthraw(address(fundme));
    vm.stopPrank();
}
function testDeposit() DepositFromARanomUser external{
        
    assert(address(fundme).balance >= 300000000000000000);
}
function testWinthraw() DepositFromARanomUser external{
    winthraw.fundme_Winthraw(address(fundme));
    assertEq(address(fundme).balance, 0);
}





    
}