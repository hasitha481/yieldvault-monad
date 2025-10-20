# YieldVault on Monad Testnet

A yield-generating vault smart contract deployed on Monad testnet with React frontend.

## Ì∫Ä Deployed Contract

- **YieldVault Address**: `0x9B9341Facc719b689649e939639343B3A5f2483D`
- **Network**: Monad Testnet (Chain ID: 10143)
- **Explorer**: [View on Monad Explorer](https://explorer.testnet.monad.xyz/address/0x9B9341Facc719b689649e939639343B3A5f2483D)
- **Transaction**: `0xdb07d7d349613b35db23820c77315ca68591ec3a79c0fa4b3f5d4923f74783dd`

## Ì≥¶ Installation
```bash
# Clone the repository
git clone https://github.com/hasitha481/yieldvault-monad.git
cd yieldvault-monad

# Install Foundry dependencies
cd yieldvault-monad
forge install

# Install frontend dependencies
cd ../yieldvault-frontend
npm install
```

## Ì¥ß Setup

1. Create `.env` file in `yieldvault-monad/`:
```env
   PRIVATE_KEY=0xyour_private_key_here
```

2. Create `.env` file in `yieldvault-frontend/`:
```env
   VITE_VAULT_ADDRESS=0x9B9341Facc719b689649e939639343B3A5f2483D
```

## Ì∫Ä Deployment
```bash
cd yieldvault-monad
forge script script/Deploy.s.sol:Deploy \
  --rpc-url https://testnet-rpc.monad.xyz \
  --broadcast \
  --legacy
```

## Ìæ® Run Frontend
```bash
cd yieldvault-frontend
npm run dev
```

## Ì≥ñ Features

- Deposit underlying tokens and receive vault shares
- Withdraw deposits anytime
- Yield accrual system (owner-managed)
- ERC20-compliant vault shares

## Ìª†Ô∏è Tech Stack

- **Smart Contracts**: Solidity 0.8.20, OpenZeppelin
- **Build Tool**: Foundry
- **Frontend**: React, Vite, TypeScript
- **Blockchain**: Monad Testnet

## Ì≥Ñ License

MIT
