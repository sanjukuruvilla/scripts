#!/bin/bash

# Check if the script is run in a git repository
if [ ! -d ".git" ]; then
    echo "Error: Not in a git repository."
    exit 1
fi

# Display git status
git status

# Add all changes and untracked files
git add .

# Commit changes with a default message
git commit -m "Auto commit"

# Push changes to origin with saved credentials
git push origin

echo "Git push completed successfully."
