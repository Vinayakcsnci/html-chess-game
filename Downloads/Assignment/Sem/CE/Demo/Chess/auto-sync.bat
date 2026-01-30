@echo off
REM Auto-sync script for chess project (Windows version)

echo Starting auto-sync for chess project...

REM Navigate to the project directory
cd /d "%~dp0"

REM Check if there are any changes to commit
git status --porcelain >nul 2>&1
if %errorlevel% equ 0 (
    echo Changes detected, preparing to commit...
    
    REM Add all relevant files
    git add .
    
    REM Commit with timestamp
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
    set commit_message=Auto-sync: %datetime:~0,8% %datetime:~8,6%
    git commit -m "%commit_message%"
    
    REM Push to remote
    echo Pushing to GitHub...
    git push origin main
    
    echo Sync completed successfully!
) else (
    echo No changes to sync.
)

pause