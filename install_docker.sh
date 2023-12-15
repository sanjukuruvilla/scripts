#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or using sudo."
    exit 1
fi

# Set non-interactive environment variable
export DEBIAN_FRONTEND=noninteractive

# Update Package Index
echo "Updating package index..."
apt-get update
echo "Package index updated successfully."

# Install Prerequisites
echo "Installing prerequisites..."
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
echo "Prerequisites installed successfully."

# Add Docker GPG Key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Docker GPG key added successfully."

# Set up Stable Docker Repository
echo "Setting up Docker repository..."
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' | tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Docker repository set up successfully."

# Update Package Index Again
echo "Updating package index again..."
apt-get update
echo "Package index updated again successfully."

# Install Docker
echo "Installing Docker..."
apt-get install -y docker-ce docker-ce-cli containerd.io
echo "Docker installed successfully."

# Start Docker Service
echo "Starting Docker service..."
systemctl start docker
echo "Docker service started successfully."

# Enable Docker on Boot
echo "Enabling Docker on boot..."
systemctl enable docker
echo "Docker enabled on boot."

# Verify Docker Version
docker --version

# Check Docker Info
echo "Checking Docker information..."
docker info
echo "Docker information checked successfully."

echo "Installation and configuration of Docker completed."

