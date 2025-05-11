#!/bin/bash
# Ref: https://code.claude.com/docs/en/settings#file-suggestion-settings

QUERY=$(jq -r '.query // ""')
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

cd "$PROJECT_DIR" || exit 1
rg --files . 2>/dev/null \
  | fzf --tmux --query="$QUERY" \
      --multi --cycle \
      --exit-0 \
      --preview "bat {}"
