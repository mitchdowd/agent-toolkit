#!/usr/bin/env bash
# Registers the Atlassian Rovo MCP server with Claude Code and Codex, if missing.

set -euo pipefail

URL="https://mcp.atlassian.com/v2/mcp"

if command -v claude >/dev/null; then
  if claude mcp list 2>/dev/null | grep -qi atlassian; then
    echo "  claude: atlassian mcp already installed"
  else
    claude mcp add --scope user --transport http atlassian "$URL"
    echo "  claude: run /mcp in a session to authenticate"
  fi
fi

if command -v codex >/dev/null; then
  if codex mcp list 2>/dev/null | grep -qi atlassian; then
    echo "  codex: atlassian mcp already installed"
  else
    codex mcp add atlassian --url "$URL"
    echo "  codex: run 'codex mcp login atlassian' to authenticate"
  fi
fi
