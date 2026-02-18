#!/bin/bash
REPO_DIR="$HOME/Documents/Code/Self/"
LOG_FILE="$HOME/.auto-git-pull.log"

echo "$REPO_DIR" >> "$LOG_FILE"
echo "======== $(date) ========" >> "$LOG_FILE"
/usr/bin/git -C "$REPO_DIR"/draft pull >> "$LOG_FILE" 2>&1
/usr/bin/git -C "$REPO_DIR"/website pull >> "$LOG_FILE" 2>&1
