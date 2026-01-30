# Auto-Sync Setup Instructions

## Quick Setup (Windows)

1. **Fix Authentication**: Run this command in your project folder to set up GitHub authentication:
   ```bash
   git config --global credential.helper store
   git push origin main
   ```
   Enter your GitHub username and a Personal Access Token (not password) when prompted.

2. **Get a Personal Access Token**:
   - Go to GitHub → Settings → Developer settings → Personal access tokens
   - Generate a new token with `repo` permissions
   - Use this token instead of your password when git asks for credentials

3. **Run Auto-Sync**:
   ```bash
   auto-sync.bat
   ```

## Automatic Scheduling (Windows)

### Method 1: Task Scheduler
1. Open Task Scheduler
2. Create Basic Task
3. Set trigger to "Daily" or "When computer starts"
4. Action: "Start a program"
5. Program: `C:\Users\lenovo\Downloads\Assignment\Sem\CE\Demo\Chess\auto-sync.bat`
6. Set repeat interval (e.g., every 5 minutes)

### Method 2: PowerShell (runs every 5 minutes)
```powershell
while ($true) {
    & "C:\Users\lenovo\Downloads\Assignment\Sem\CE\Demo\Chess\auto-sync.bat"
    Start-Sleep -Seconds 300
}
```

## Manual Sync
```bash
git add .
git commit -m "Update: $(date)"
git push origin main
```

## Troubleshooting
- **Permission denied**: Make sure your Personal Access Token has `repo` permissions
- **Authentication failed**: Run `git config --global credential.helper store` and re-enter credentials
- **No changes detected**: The script will skip if there are no new changes