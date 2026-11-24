# ADR 0001: Hybrid stack and Arbitrum MCP integration

- Status: Accepted
- Date: 2026-11-24

## Context

Demandable Core is a hybrid product: an AI-powered demand-generation platform (outreach, qualification, engagement) with Web3 escrow payments on Arbitrum. The repository currently contains only documentation and the Arbitrum MCP integration (`.mcp/arbitrum-mcp.json`, `scripts/install-arbitrum-mcp.sh`, `docs/integrations/arbitrum-mcp.md`). The API and contracts are not built yet.

## Decision

1. **Stack:** a TypeScript/Node.js API foundation and Solidity smart contracts developed, tested, and deployed with Foundry.
2. **Component roles:**
   - *Core API* (TypeScript/Node.js): the service boundary. It hosts demand-generation logic (agents, workflows, qualification) and orchestrates the escrow lifecycle (create, fund, deliver, release/refund) by calling the contracts.
   - *Escrow contracts* (Solidity/Foundry, Arbitrum): hold funds and enforce settlement rules on-chain. They contain no demand-generation logic.
   - *Arbitrum MCP server* (Docker image `dewanshparashar/arbitrum-mcp`, run over stdio via `docker run -i --rm`): a Model Context Protocol tool server that gives AI agents and developer tooling Arbitrum-specific capabilities. It is configured in MCP clients, and AI agents in the core API may use it when working on the escrow layer. It is not part of the settlement path and holds no funds or keys.
3. **Flow:** a demand-gen engagement is defined in the API, the API creates and funds an escrow on Arbitrum, agents and users record delivery milestones through the API, and the API triggers release or refund on the contract. The MCP server supports agents and developers throughout but never replaces the API or contracts.

## Consequences

- One language (TypeScript) for the API and agent tooling; Foundry covers contract testing and deployment.
- Clear trust boundary: only the contracts custody funds; the MCP server is auxiliary tooling.
- The MCP integration requires Docker.
- All of the above is planned; see [ROADMAP.md](../../ROADMAP.md). Revisit this ADR if the stack or integration model changes.
