#!/usr/bin/env bash
set -e

echo "=== Claude Code + Copilot API Setup ==="
echo

echo "Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code

echo
echo "Installing Copilot API proxy..."
npm install -g copilot-api

echo
echo "Creating Claude settings directory..."
mkdir -p ~/.claude

echo
echo "Verifying installation..."
echo -n "  claude-code: "
claude --version 2>/dev/null || echo "not found"
echo -n "  copilot-api: "
command -v copilot-api > /dev/null && echo "installed" || echo "not found"

echo
echo "=== Setup Complete ==="
echo
echo "Next steps:"
echo "  1. Authenticate:  copilot-api start"
echo "  2. Start proxy:   copilot-api start --claude-code"
echo "  3. Launch Claude: ./scripts/start-claude.sh"
echo
