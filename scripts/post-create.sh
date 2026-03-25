#!/usr/bin/env bash

set -euo pipefail

USERNAME=vscode
USER_HOME="/home/$USERNAME"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Keep shell history across container sessions.
mkdir -p /commandhistory
sudo touch /commandhistory/.zsh_history
sudo chown -R "$USERNAME" /commandhistory
grep -Fqx "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.zsh_history" "$USER_HOME/.zshrc" || \
    echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.zsh_history" >> "$USER_HOME/.zshrc"

# Install workspace-only Python tooling declared in pyproject.toml.
cd "$REPO_ROOT"
uv sync --dev

# Point Claude Code at the local Copilot proxy.
mkdir -p "$USER_HOME/.claude"
cat > "$USER_HOME/.claude/settings.json" << 'EOF'
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:4141",
    "ANTHROPIC_MODEL": "claude-opus-4.6",
    "ANTHROPIC_API_KEY": "dummy",
    "ANTHROPIC_AUTH_TOKEN": "dummy",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet-4.6",
    "ANTHROPIC_SMALL_FAST_MODEL": "gpt-5-mini",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "gpt-5-mini",
    "DISABLE_NON_ESSENTIAL_MODEL_CALLS": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  },
  "model": "claude-opus-4.6"
}
EOF

echo "Setup complete"
echo "  1. Run 'uv run poe proxy-start'"
echo "  2. Open a new terminal and run 'uv run poe claude-chat'"



