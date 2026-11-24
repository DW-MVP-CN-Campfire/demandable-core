# Demandable Core

An open-source, hybrid platform: **AI-powered demand generation** combined with **Web3 escrow payments on Arbitrum**. Organizations can deploy, extend, and own the infrastructure that finds, qualifies, and engages demand, and settle engagements through a transparent smart-contract escrow market.

> **Status:** early stage. The planned stack is a TypeScript/Node.js API plus Solidity contracts built with Foundry. Those components are not built yet; today the repository contains documentation, the Arbitrum MCP integration setup, and helper scripts.

## Vision

Human-centered demand-generation infrastructure that organizations can deploy, extend, and own, with trustless escrow so buyers and providers can transact without a middleman.

## Features

Available now:

- Arbitrum MCP server setup for AI tooling ([docs](docs/integrations/arbitrum-mcp.md))

Planned (see [ROADMAP.md](ROADMAP.md)):

- AI agents and outreach workflows
- CRM integrations, pipeline analytics, lead intelligence
- Automation tooling
- Smart-contract escrow for demand-generation engagements on Arbitrum

## Quick Start

Prerequisite: [Docker](https://docs.docker.com/get-docker/).

1. Pull the Arbitrum MCP server image:

   ```bash
   ./scripts/install-arbitrum-mcp.sh
   ```

   This runs `docker pull dewanshparashar/arbitrum-mcp`.

2. Add the server definition from [`.mcp/arbitrum-mcp.json`](.mcp/arbitrum-mcp.json) to your MCP client's `mcpServers` configuration. It starts the server with `docker run -i --rm dewanshparashar/arbitrum-mcp`.

Instructions for running the API and building/testing the contracts will be added once the TypeScript and Foundry code lands.

## Documentation

- [Arbitrum MCP integration](docs/integrations/arbitrum-mcp.md)
- [Architecture decisions](docs/adr/) — start with [ADR 0001](docs/adr/0001-hybrid-stack-and-arbitrum-mcp.md)
- [Roadmap](ROADMAP.md)

## Community and Policies

- [Contributing](CONTRIBUTING.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Security Policy](SECURITY.md)
- [Governance](GOVERNANCE.md)
- [Trademarks](TRADEMARKS.md)
- [Changelog](CHANGELOG.md)

## License

See [LICENSE](LICENSE).
