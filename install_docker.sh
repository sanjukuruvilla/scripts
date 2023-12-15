#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or using sudo."
    exit 1
fi

# Set non-interactive environment variables
export DEBIAN_FRONTEND=noninteractive
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Update Package Index
echo "Updating package index..."
apt-get update -y
echo "Package index updated successfully."

# Install Prerequisites
echo "Installing prerequisites without user input..."
apt-get install -yq apt-transport-https ca-certificates curl software-properties-common
echo "Prerequisites installed successfully."

# Add Docker GPG Key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Docker GPG key added successfully."

# Force update the keyring without prompting
echo "Forcing update of Docker GPG keyring..."
gpgconf --kill gpg-agent
echo "Docker GPG keyring updated successfully."

# Set up Stable Docker Repository
echo "Setting up Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Docker repository set up successfully."

# Update Package Index Again
echo "Updating package index again..."
apt-get update -y
echo "Package index updated again successfully."

# Install Docker
echo "Installing Docker..."
apt-get install -yq docker-ce docker-ce-cli containerd.io
if [ $? -eq 0 ]; then
    echo "Docker installed successfully."
else
    echo "Error: Failed to install Docker."
    exit 1
fi

# Create Docker Group (if not exists)
echo "Creating Docker group..."
groupadd -f docker
echo "Docker group created successfully."

# Add User to Docker Group
echo "Adding user to Docker group..."
usermod -aG docker $(whoami)
echo "User added to Docker group successfully."

# Start Docker Service
echo "Starting Docker service..."
systemctl start docker
if [ $? -eq 0 ]; then
    echo "Docker service started successfully."
else
    echo "Error: Failed to start Docker service."
    exit 1
fi

# Enable Docker on Boot
echo "Enabling Docker on boot..."
systemctl enable docker
if [ $? -eq 0 ]; then
    echo "Docker enabled on boot."
else
    echo "Error: Failed to enable Docker on boot."
    exit 1
fi

# Verify Docker Version
docker --version

# Check Docker Info
echo "Checking Docker information..."
docker info
echo "Docker information checked successfully."

echo "Installation and configuration of Docker completed."

