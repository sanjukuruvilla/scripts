#!/bin/bash

# Stop Docker service
sudo systemctl stop docker

# Remove Docker packages
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io

# Delete Docker-related directories
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker

# Remove Docker group
sudo groupdel docker

# Remove Docker user
sudo userdel -r docker

# Remove Docker GPG key
sudo apt-key del 0EBFCD88

# Remove Docker repository
sudo rm /etc/apt/sources.list.d/docker.list

# Update package list
sudo apt-get update

echo "Docker has been completely removed from the system."

# Automatically answer 'y' to remove Docker dependencies
sudo apt-get autoremove -y --purge
echo "Docker dependencies have been removed."

echo "Script execution complete."

