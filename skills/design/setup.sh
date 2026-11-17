#!/usr/bin/env bash
# Installs agent-browser (used to render and screenshot designs), if missing.

set -euo pipefail

if command -v agent-browser >/dev/null; then
  echo "  agent-browser already installed"
elif command -v npm >/dev/null; then
  npm install -g agent-browser
  agent-browser install
else
  echo "  npm not found: install Node, then run 'npm install -g agent-browser && agent-browser install'" >&2
fi
