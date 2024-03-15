#!/bin/bash

# Function to install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    echo "kubectl installation completed."
}

# Main script
echo "Welcome to kubectl installation script!"
echo "Checking the operating system..."

# Check if the OS is Debian/Ubuntu
if [ -x "$(command -v apt)" ]; then
    echo "Detected Debian/Ubuntu."
    install_kubectl

# Check if the OS is CentOS/RHEL
elif [ -x "$(command -v yum)" ]; then
    echo "Detected CentOS/RHEL."
    install_kubectl

else
    echo "Unsupported operating system. Please install kubectl manually."
    exit 1
fi

echo "Script execution completed."

