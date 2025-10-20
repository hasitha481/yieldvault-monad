import { ERC20, Account, Approval } from "generated";  // From codegen: ERC20 namespace, Account/Approval entities

// Approval Handler: Tracks approvals (e.g., for delegation spending limits)
ERC20.Approval.handler(async ({ event, context }) => {  // Implicit types: event.params any, context Envio's IndexingContext
  // Get owner account (create if missing)
  let ownerAccount = await context.Account.get(event.params.owner.toString());
  if (ownerAccount === undefined) {
    const accountObject: Account = {
      id: event.params.owner.toString(),
      balance: 0n,  // bigint literal
    };
    context.Account.set(accountObject);
  }

  // Create/update approval entity
  const approvalId = event.params.owner.toString() + "-" + event.params.spender.toString();
  const approvalObject: Approval = {
    id: approvalId,
    amount: BigInt(event.params.value),  // Fix: Coerce string/number to bigint
    owner_id: event.params.owner.toString(),
    spender_id: event.params.spender.toString(),
  };
  context.Approval.set(approvalObject);  // Uses generated Approval entity

  console.log(`Approval: ${event.params.owner} -> ${event.params.spender} for ${BigInt(event.params.value)}`);

  // AI rebalance logic: e.g., query enforcer for timebound/ratelimit, trigger if over limit
  // await aiRebalance(event.params.owner, BigInt(event.params.value), context);
});

// Transfer Handler: Updates balances (handles mint/burn from zero address)
ERC20.Transfer.handler(async ({ event, context }) => {
  const value = BigInt(event.params.value);  // Coerce once for reuse

  // Sender (from) logic
  let senderAccount = await context.Account.get(event.params.from.toString());
  if (senderAccount === undefined) {
    // Likely mint (from zero) or first burn
    const accountObject: Account = {
      id: event.params.from.toString(),
      balance: 0n - value,  // bigint ops safe
    };
    context.Account.set(accountObject);
  } else {
    const accountObject: Account = {
      id: senderAccount.id,
      balance: senderAccount.balance - value,
    };
    context.Account.set(accountObject);
  }

  // Receiver (to) logic
  let receiverAccount = await context.Account.get(event.params.to.toString());
  if (receiverAccount === undefined) {
    const accountObject: Account = {
      id: event.params.to.toString(),
      balance: value,
    };
    context.Account.set(accountObject);
  } else {
    const accountObject: Account = {
      id: receiverAccount.id,
      balance: receiverAccount.balance + value,
    };
    context.Account.set(accountObject);
  }

  console.log(`Transfer: ${event.params.from} -> ${event.params.to} for ${value}`);

  // AI rebalance logic: e.g., if transfer to enforcer, check allowlist/ratelimit
  // await checkEnforcerLimits(event.params.to, value, context);
});