@echo off
REM Auto-sync script for HTML Chess Game (Windows version)
REM This script automatically commits and pushes changes to GitHub

echo Starting auto-sync for HTML Chess Game...

REM Navigate to the project directory
cd /d "%~dp0"

REM Check if there are any changes
git status --porcelain > temp_status.txt
set /p STATUS=<temp_status.txt
del temp_status.txt

if defined STATUS (
    echo Changes detected, preparing to sync...

    REM Add all files
    git add .

    REM Create timestamp for commit message
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
    set commit_message=Auto-sync: %datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%

    REM Commit changes
    git commit -m "%commit_message%"

    REM Push to GitHub
    echo Pushing to GitHub...
    git push origin main

    if %errorlevel% equ 0 (
        echo Sync completed successfully!
    ) else (
        echo Push failed. Please check your connection and try again.
    )
) else (
    echo No changes to sync.
)

REM Check for --once argument
if "%1"=="--once" (
    exit /b
)

REM Continuous mode - wait and repeat
echo.
echo Waiting 30 seconds before next sync check...
echo Press Ctrl+C to stop.
timeout /t 30 /nobreak > nul
goto :start

:start
cls
call "%~f0" --once
goto :start
