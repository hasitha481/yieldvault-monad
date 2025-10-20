import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";

export default function Index() {
  return (
    <main className="min-h-screen bg-gradient-to-b from-background to-background/60">
      <section className="container grid items-center gap-8 py-16">
        <div>
          <h1 className="text-4xl font-extrabold tracking-tight">DeFi on Autopilot</h1>
          <p className="mt-4 text-lg text-muted-foreground">
            MonadYield AI uses delegated smart accounts to optimize yields on Monad testnet.
          </p>
          <div className="mt-6 flex gap-3">
            <Link to="/dashboard">
              <Button>View Dashboard</Button>
            </Link>
          </div>
        </div>
      </section>
    </main>
  );
}