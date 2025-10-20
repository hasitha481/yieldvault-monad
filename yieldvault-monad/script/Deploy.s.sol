// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {YieldVault} from "../src/YieldVault.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // OPTION 1: Use a placeholder address for initial testing
        address underlying = 0x0000000000000000000000000000000000000001;
        
        // OPTION 2: Or use an actual testnet token if you have one
        // address underlying = 0xYourTestnetTokenAddress;
        
        YieldVault vault = new YieldVault(underlying);
        console.log("================================");
        console.log("YieldVault deployed at:", address(vault));
        console.log("Underlying asset:", underlying);
        console.log("================================");

        vm.stopBroadcast();
    }
}