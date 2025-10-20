import { defineChain } from 'viem';

export const monadTestnet = defineChain({
  id: 10143,
  name: 'Monad Testnet',
  nativeCurrency: { name: 'MON', symbol: 'MON', decimals: 18 },
  rpcUrls: {
    default: { http: ['https://monad-testnet.g.alchemy.com/v2/wHSLe7jBSwNFhwJWoiKNNbcnD39L0LQN'] },
  },
  blockExplorers: {
    default: { name: 'Monad Explorer', url: 'https://explorer.testnet.monad.xyz' },
  },
  testnet: true,
});
