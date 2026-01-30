#!/bin/bash

# Auto-Sync Setup Script for Chess Game
echo "Setting up auto-sync for Chess Game repository..."

# Create a pre-commit hook for auto-sync
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
echo "🔄 Auto-syncing to GitHub..."
git push origin main
echo "✅ Successfully synced to GitHub!"
EOF

# Make the hook executable
chmod +x .git/hooks/pre-commit

# Create an auto-sync script for manual use
cat > sync.sh << 'EOF'
#!/bin/bash
echo "🔄 Syncing Chess Game to GitHub..."
git add .
if git diff --staged --quiet; then
    echo "No changes to commit."
else
    git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "✅ Successfully synced to GitHub!"
fi
EOF

chmod +x sync.sh

echo "✅ Auto-sync setup complete!"
echo "Now any commit will automatically push to GitHub."
echo "You can also run './sync.sh' to manually sync changes."

# Create a package.json script for easier syncing (optional)
if [ ! -f package.json ]; then
    cat > package.json << 'EOF'
{
  "name": "html-chess-game",
  "version": "1.0.0",
  "description": "Interactive HTML chess game with full gameplay",
  "scripts": {
    "sync": "./sync.sh",
    "serve": "python -m http.server 8000"
  },
  "keywords": ["chess", "game", "html", "javascript"],
  "author": "Vinayakcsnci",
  "license": "MIT"
}
EOF
fi

echo "📝 Package.json created with sync script."
echo "You can now run 'npm run sync' to sync changes."