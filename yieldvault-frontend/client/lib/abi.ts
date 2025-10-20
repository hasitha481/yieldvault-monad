export const YieldVaultAbi = [
  {
    "type": "function",
    "name": "deposit",
    "inputs": [],
    "outputs": [{ "type": "uint256" }],
    "stateMutability": "payable"
  },
  {
    "type": "function",
    "name": "withdraw",
    "inputs": [{ "name": "shares", "type": "uint256" }],
    "outputs": [{ "type": "uint256" }],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "harvest",
    "inputs": [],
    "outputs": [],
    "stateMutability": "nonpayable"
  },
  {
    "type": "function",
    "name": "balanceOf",
    "inputs": [{ "name": "account", "type": "address" }],
    "outputs": [{ "type": "uint256" }],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "totalAssets",
    "inputs": [],
    "outputs": [{ "type": "uint256" }],
    "stateMutability": "view"
  },
  {
    "type": "function",
    "name": "totalSupply",
    "inputs": [],
    "outputs": [{ "type": "uint256" }],
    "stateMutability": "view"
  },
  {
    "type": "event",
    "name": "Deposit",
    "inputs": [
      { "indexed": true, "name": "depositor", "type": "address" },
      { "indexed": false, "name": "amount", "type": "uint256" }
    ]
  },
  {
    "type": "event",
    "name": "Withdraw",
    "inputs": [
      { "indexed": true, "name": "withdrawer", "type": "address" },
      { "indexed": false, "name": "amount", "type": "uint256" }
    ]
  },
  {
    "type": "event",
    "name": "Harvest",
    "inputs": [
      { "indexed": false, "name": "yieldAmount", "type": "uint256" }
    ]
  }
] as const;
