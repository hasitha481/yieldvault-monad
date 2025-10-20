import "./global.css";
import { Toaster } from "@/components/ui/toaster";
import { Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Link } from "react-router-dom";
import Index from "./pages/Index";
import NotFound from "./pages/NotFound";
import Dashboard from "./pages/Dashboard";
import { ThemeProvider } from "./providers/ThemeProvider";
import { WagmiProvider, createConfig, http } from "wagmi";
import { metaMask } from "wagmi/connectors";
import { monadTestnet } from "@/lib/chains";
import WalletConnect from "@/components/WalletConnect";
import { Button } from "@/components/ui/button";
import { useTheme } from "next-themes";

const queryClient = new QueryClient();

const wagmiConfig = createConfig({
  chains: [monadTestnet],
  connectors: [metaMask()],
  transports: {
    [monadTestnet.id]: http(import.meta.env.VITE_MONAD_RPC_URL || monadTestnet.rpcUrls.default.http[0]),
  },
});

function ThemeToggle() {
  const { theme, setTheme, resolvedTheme } = useTheme();
  const isDark = (theme ?? resolvedTheme) === "dark";
  return (
    <Button variant="ghost" size="sm" onClick={() => setTheme(isDark ? "light" : "dark")}>
      {isDark ? "☀️" : "🌙"}
    </Button>
  );
}

function Navbar() {
  return (
    <header className="sticky top-0 z-20 border-b bg-background/80 backdrop-blur">
      <nav className="container flex h-14 items-center justify-between">
        <Link to="/" className="flex items-center gap-2 font-semibold">
          <span className="inline-block h-2 w-2 rounded-full bg-primary"></span>
          MonadYield AI
        </Link>
        <div className="flex items-center gap-2">
          <Link to="/dashboard" className="hidden text-sm text-muted-foreground hover:text-foreground md:inline">Dashboard</Link>
          <ThemeToggle />
          <WalletConnect />
        </div>
      </nav>
    </header>
  );
}

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <WagmiProvider config={wagmiConfig}>
        <TooltipProvider>
          <ThemeProvider>
            <Toaster />
            <Sonner />
            <BrowserRouter>
              <Navbar />
              <Routes>
                <Route path="/" element={<Index />} />
                <Route path="/dashboard" element={<Dashboard />} />
                <Route path="*" element={<NotFound />} />
              </Routes>
            </BrowserRouter>
          </ThemeProvider>
        </TooltipProvider>
      </WagmiProvider>
    </QueryClientProvider>
  );
}