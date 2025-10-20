// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";  // Assume OZ installed via forge install

contract YieldVault is ERC20 {
    error Unauthorized();
    error InsufficientBalance();

    address public owner;
    uint256 public totalYield;  // Mock total yields accrued

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event Harvest(address indexed user, uint256 yieldAmount);  // For Envio indexing

    constructor() ERC20("YieldVault Share", "YVS") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized();
        _;
    }

    function deposit(uint256 amount) external {
        if (amount == 0) revert InsufficientBalance();
        _mint(msg.sender, amount);
        // Mock yield accrual (in prod: real farming logic)
        totalYield += amount / 100;  // 1% mock yield
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        if (balanceOf(msg.sender) < amount) revert InsufficientBalance();
        _burn(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }

    function harvest() external {
        uint256 userYield = balanceOf(msg.sender) / 100;  // Mock per user
        if (userYield == 0) revert InsufficientBalance();
        _mint(msg.sender, userYield);
        totalYield -= userYield;
        emit Harvest(msg.sender, userYield);
    }

    // For AI agent: Batch deposit + harvest
    function batchDepositAndHarvest(uint256 amount) external {
        deposit(amount);
        harvest();
    }
}