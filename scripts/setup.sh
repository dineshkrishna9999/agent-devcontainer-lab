#!/usr/bin/env bash
set -euo pipefail

echo "=== Claude Code + Copilot API Setup ==="
echo

if ! command -v npm >/dev/null 2>&1; then
    echo "npm not found. Rebuild the dev container and re-run this script."
    exit 1
fi

echo "Installing Claude Code CLI and Copilot API proxy..."
npm install -g @anthropic-ai/claude-code copilot-api

echo
echo "Creating Claude settings directory..."
mkdir -p ~/.claude

echo
echo "Verifying installation..."
echo -n "  claude-code: "
claude --version 2>/dev/null || echo "not found"
echo -n "  copilot-api: "
command -v copilot-api >/dev/null && echo "installed" || echo "not found"

echo
echo "=== Setup Complete ==="
echo
echo "Next steps:"
echo "  1. Authenticate:  uv run poe proxy-auth"
echo "  2. Start proxy:   uv run poe proxy-start"
echo "  3. Launch Claude: uv run poe claude-chat"
echo
