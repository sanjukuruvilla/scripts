#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

#start
echo "The cleaning started--"

# Update package lists
sudo apt-get update

# Upgrade installed packages
sudo apt-get upgrade -y

# Remove unused dependencies
sudo apt-get autoremove -y

# Remove orphaned packages
sudo apt-get autoclean -y

# Clean APT cache
sudo apt-get clean

# Remove old configuration files
sudo dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get purge -y

#end
echo "The cleaning completed" 

