#!/bin/bash

# Stop Jenkins service
sudo systemctl stop jenkins

# Disable Jenkins service from starting on boot
sudo systemctl disable jenkins

# Uninstall Jenkins package
sudo apt-get purge -y jenkins

# Remove Jenkins configuration and data
sudo rm -rf /var/lib/jenkins
sudo rm -rf /etc/default/jenkins
sudo rm -rf /etc/init.d/jenkins
sudo rm -rf /var/log/jenkins

# Remove Jenkins repository entry
sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo apt-key del D50582E6

# Update package lists
sudo apt-get autoremove -y
sudo apt-get update

echo "Jenkins has been completely removed from the system."

