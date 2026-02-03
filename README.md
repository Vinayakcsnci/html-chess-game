# Chess Game - HTML

An interactive HTML chess game with full gameplay functionality.

## Features

- Full chess board with all pieces
- Interactive piece movement
- Turn-based gameplay
- Legal move validation
- Check and checkmate detection

## Setup

1. **Create GitHub Repository:**
   ```bash
   bash setup-repo.sh
   ```

2. **Push to GitHub:**
   Follow the instructions from the setup script

3. **Enable Auto-Sync:**
   ```bash
   bash setup-auto-sync.sh
   ```

## Usage

### Manual Sync
```bash
./sync.sh       # Linux/Mac
sync.bat        # Windows
# or
npm run sync
```

### Automatic Sync
Any commit will automatically push to GitHub due to the pre-commit hook.

### Local Development
```bash
npm run serve
# then open http://localhost:8000
```

## Repository Structure

```
Chess/
├── chess-game.html    # Main game file
├── setup-repo.sh     # Initial repository setup
├── setup-auto-sync.sh # Auto-sync configuration
└── README.md         # This file
```

## Auto-Sync Features

- **Pre-commit Hook:** Automatically pushes changes on every commit
- **Manual Sync Script:** Quick sync without committing
- **Package.json Scripts:** Easy npm commands for development and syncing

The repository is configured to automatically sync all changes to GitHub, ensuring your chess game is always backed up and up-to-date.