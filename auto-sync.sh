#!/bin/bash

# Auto-sync script for chess project
# This script will automatically commit and push changes to GitHub

echo "Starting auto-sync for chess project..."

# Navigate to the project directory
cd "$(dirname "$0")"

# Check if there are any changes to commit
if [[ -n $(git status --porcelain) ]]; then
    echo "Changes detected, preparing to commit..."
    
    # Add all relevant files
    git add .
    
    # Commit with timestamp
    commit_message="Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$commit_message"
    
    # Push to remote (you may need to authenticate)
    echo "Pushing to GitHub..."
    git push origin main
    
    echo "Sync completed successfully!"
else
    echo "No changes to sync."
fi

# Schedule next sync (if running on Linux/macOS with cron)
# Add this line to your crontab to run every 5 minutes:
# */5 * * * * /path/to/this/script.sh