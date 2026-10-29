#!/usr/bin/env bash
# Installs the Codacy Cloud CLI, if missing.

set -euo pipefail

if command -v codacy >/dev/null; then
  echo "  codacy cli already installed"
elif command -v npm >/dev/null; then
  npm install -g @codacy/codacy-cloud-cli
  echo "  run 'codacy login' to authenticate"
else
  echo "  npm not found: install Node, then run 'npm install -g @codacy/codacy-cloud-cli'" >&2
fi
