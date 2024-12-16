// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Vulnerable.sol"; 
import "../src/Attacker.sol"; 

contract ReentrancyTest is Test {
    Vulnerable private vulnerable;
    Attacker private attacker;

    function setUp() public {
        vulnerable = new Vulnerable();
        attacker = new Attacker(address(vulnerable)); 
    }


    function testFuzzReentrancyAttack(uint256 depositAmount, uint256 withdrawAmount) public {

        require(depositAmount > 0 && withdrawAmount > 0, "Amounts must be positive");


        vulnerable.deposit{value: depositAmount}();


        vm.expectRevert(); 
        attacker.attack(withdrawAmount);
    }
}

