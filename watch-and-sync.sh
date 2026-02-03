#!/bin/bash

# Real-time file watcher for auto-sync
# Requires: inotifywait (Linux) or fswatch (macOS)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BRANCH="${GIT_BRANCH:-main}"

sync_now() {
    if [[ -n $(git status --porcelain) ]]; then
        echo "[$(date '+%H:%M:%S')] Syncing changes..."
        git add .
        git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
        git push origin "$BRANCH"
    fi
}

# Detect OS and use appropriate watcher
if command -v inotifywait &> /dev/null; then
    echo "Using inotifywait for file watching..."
    while inotifywait -r -e modify,create,delete --exclude '\.git' .; do
        sleep 2  # debounce
        sync_now
    done
elif command -v fswatch &> /dev/null; then
    echo "Using fswatch for file watching..."
    fswatch -o --exclude '\.git' . | while read; do
        sleep 2  # debounce
        sync_now
    done
else
    echo "No file watcher found. Install inotify-tools (Linux) or fswatch (macOS)."
    echo "Falling back to polling mode..."
    ./auto-sync.sh
fi
