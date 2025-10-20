// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/YieldVault.sol";

contract YieldVaultTest is Test {
    YieldVault vault;
    address user = makeAddr("user");

    function setUp() public {
        vault = new YieldVault();
        vm.deal(user, 1000 ether);
    }

    function testDeposit() public {
        vm.prank(user);
        vault.deposit(100 ether);
        assertEq(vault.balanceOf(user), 100 ether);
    }

    function testHarvest() public {
        vm.prank(user);
        vault.deposit(100 ether);
        vm.prank(user);
        vault.harvest();
        assertGt(vault.balanceOf(user), 100 ether);
    }

    function testBatch() public {
        vm.prank(user);
        vault.batchDepositAndHarvest(100 ether);
        assertGt(vault.balanceOf(user), 100 ether);
    }
}