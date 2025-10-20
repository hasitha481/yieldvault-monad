// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract YieldVault is ERC20, Ownable {
    address public underlyingAsset;
    uint256 public totalDeposited;
    uint256 public totalYield;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event YieldAccrued(uint256 amount);

    constructor(address _underlyingAsset) ERC20("YieldVault Shares", "YVS") Ownable(msg.sender) {
        underlyingAsset = _underlyingAsset;
    }

    function deposit(uint256 amount) external {
        // Transfer underlying from user
        IERC20(underlyingAsset).transferFrom(msg.sender, address(this), amount);
        totalDeposited += amount;
        uint256 shares = (amount * totalSupply()) / totalDeposited; // Simplified mint logic
        if (totalSupply() == 0) shares = amount;
        _mint(msg.sender, shares);
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 shares) external {
        uint256 amount = (shares * totalDeposited) / totalSupply();
        _burn(msg.sender, shares);
        totalDeposited -= amount;
        IERC20(underlyingAsset).transfer(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }

    // Placeholder for yield accrual (integrate with your yield source)
    function accrueYield(uint256 yieldAmount) external onlyOwner {
        totalYield += yieldAmount;
        emit YieldAccrued(yieldAmount);
    }
}