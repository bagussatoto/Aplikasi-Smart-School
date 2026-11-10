# Auto-push script for Aplikasi Smart School
# This PowerShell script stages all changes, creates a commit with a timestamped message, and pushes to the remote repository.
# Ensure you have git installed and the remote "origin" configured.

# Change to the repository root (adjust if the script is called from elsewhere)
Set-Location "$(Split-Path -Parent $MyInvocation.MyCommand.Path)\.."

# Stage all changes
git add -A

# Create a commit message with current datetime
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMsg = "Auto-commit: $timestamp"

git commit -m $commitMsg

# Push to the remote (origin, default branch)
git push origin HEAD

Write-Host "Auto-push completed: $commitMsg"

