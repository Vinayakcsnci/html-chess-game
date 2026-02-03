@echo off
REM Manual sync script - pulls latest changes and pushes local commits

echo Syncing with GitHub...
echo.

echo Fetching from remote...
git fetch origin

echo.
echo Pulling latest changes...
git pull origin main --rebase

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Warning: Pull failed. You may have conflicts to resolve.
    exit /b 1
)

echo.
echo Pushing local changes...
git push origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Sync complete!
) else (
    echo.
    echo Warning: Push failed. Check your connection or credentials.
)
