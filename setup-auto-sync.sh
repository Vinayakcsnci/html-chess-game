#!/bin/bash

# Setup script for enabling auto-sync to GitHub
# This configures git hooks to automatically push changes

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Setting up auto-sync for HTML Chess Game..."

# Ensure we're in a git repository
if [ ! -d ".git" ]; then
    echo "Error: Not a git repository. Please initialize git first."
    exit 1
fi

# Create post-commit hook for automatic push after each commit
cat > .git/hooks/post-commit << 'EOF'
#!/bin/bash
# Auto-push to GitHub after each commit

BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Auto-pushing to origin/$BRANCH..."

if git push origin "$BRANCH"; then
    echo "Successfully synced to GitHub!"
else
    echo "Push failed. You may need to push manually."
fi
EOF

chmod +x .git/hooks/post-commit

# Create a fswatch/inotify-based watcher script for real-time sync (optional)
cat > watch-and-sync.sh << 'EOF'
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
EOF

chmod +x watch-and-sync.sh

# Make auto-sync.sh executable
chmod +x auto-sync.sh 2>/dev/null

echo ""
echo "Auto-sync setup complete!"
echo ""
echo "Available sync methods:"
echo "  1. Post-commit hook (enabled) - Automatically pushes after each git commit"
echo "  2. ./auto-sync.sh             - Manual sync or polling daemon (every 30s)"
echo "  3. ./auto-sync.sh --once      - One-time sync"
echo "  4. ./watch-and-sync.sh        - Real-time file watching (requires inotify/fswatch)"
echo ""
echo "For continuous background sync, add to crontab:"
echo "  */5 * * * * cd $SCRIPT_DIR && ./auto-sync.sh --once"
