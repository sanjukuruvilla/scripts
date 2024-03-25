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

#---------------To automate giving username and  password------------------------------- 

#Make sure that you have set up Git credentials to avoid entering username and password every time. You can use the following command to cache your credentials:

#bash

#git config --global credential.helper cache

#This will cache your credentials for 15 minutes by default. You can adjust the timeout by adding --timeout to the command, like this:

#bash

#git config --global credential.helper 'cache --timeout=3600'  # Set timeout to 1 hour

#This way, you won't be prompted for your username and password every time you push changes.
