// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Deploy} from "../script/Deploy.s.sol";
import {Fundme} from "../src/Fundme.sol";
import {StdCheats} from "../lib/forge-std/src/StdCheats.sol";
contract FundmeTest is StdCheats , Test{
    Fundme public fundme;
    address public user;

    
function setUp() external {
    Deploy deploy = new Deploy();
    fundme = deploy.run();
     user = makeAddr("Neo");
 

}
modifier DepositFromARanomUser {
    vm.deal(user, 10 ether);
    vm.prank(user);
    // hoax(user,10 ether); this is the same as the 2 above
    fundme.Fund{ value: 100000000000000000 }();

    _;
}
modifier OwnerWinthrawAtTheEnd {
    _;
    vm.startPrank(fundme.i_owner());
    fundme.withraw();
    vm.stopPrank();

}
function testDepositFromARanomUser() DepositFromARanomUser external{
        
    assert(address(fundme).balance >= 100000000000000000);
}
function testWinthrawFromARanomUserWhoIsNotTheOwner() DepositFromARanomUser external{
    vm.expectRevert();
    fundme.withraw();
}
function testWinthrawFromTheOwner() DepositFromARanomUser OwnerWinthrawAtTheEnd external{
    
}
function testToCheckIfFunderGetsAddedToFundersArray() DepositFromARanomUser  external{
    assertEq(fundme.get_fundersarray(0), user);
    
    
}
function testToCheckIfTheBalanceOfAUserGetUpdatedAfterTheyDeposit() DepositFromARanomUser  external{
    assertEq(fundme.get_balances(user), 100000000000000000);
    
    
}
function testIfTheArrayGetsResetedAfterTheOwnerWinthraw() DepositFromARanomUser  external{
    vm.prank(fundme.i_owner());
    fundme.withraw();
    assertEq(fundme.get_fundersarraylength(),0);
   
}
function testIfTheBalancesGetsResetedAfterTheOwnerWinthraw() DepositFromARanomUser  external{
    vm.prank(fundme.i_owner());
    fundme.withraw();
    assertEq(fundme.get_balances(user), 0);
}
function testIfTheOwnerRecievesItsPaymentWhenAfterWithrawing() DepositFromARanomUser  external{
    uint BalanceBefore = address(fundme.i_owner()).balance;
    vm.prank(fundme.i_owner());
    fundme.withraw();
    uint BalanceAfter = address(fundme.i_owner()).balance;
    assertEq(BalanceAfter - BalanceBefore , 100000000000000000);
    
}




    
}