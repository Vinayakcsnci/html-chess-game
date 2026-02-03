#!/bin/bash

# Auto-sync script for HTML Chess Game
# This script monitors for changes and automatically syncs to GitHub

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Configuration
SYNC_INTERVAL=30  # seconds between sync checks
BRANCH="${GIT_BRANCH:-main}"

sync_changes() {
    if [[ -n $(git status --porcelain) ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Changes detected, syncing..."

        git add .

        commit_message="Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
        git commit -m "$commit_message"

        if git push origin "$BRANCH"; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Sync completed successfully!"
        else
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] Push failed, will retry next cycle"
        fi
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] No changes to sync."
    fi
}

# One-time sync mode
if [[ "$1" == "--once" ]]; then
    sync_changes
    exit 0
fi

# Continuous sync mode (default)
echo "Starting auto-sync daemon for HTML Chess Game..."
echo "Watching for changes every ${SYNC_INTERVAL} seconds..."
echo "Press Ctrl+C to stop."
echo ""

while true; do
    sync_changes
    sleep "$SYNC_INTERVAL"
done
