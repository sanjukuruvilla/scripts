#!/bin/bash

# Function to install AWS CLI version 2 on Linux x86 (64-bit)
install_awscli_linux_x86_64() {
    # Install unzip if not already installed
    sudo apt-get update && sudo apt-get install -y unzip
    # Download AWS CLI installation package
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    # Unzip the package
    unzip awscliv2.zip
    # Run the installation script
    sudo ./aws/install
}

# Function to install AWS CLI version 2 on Linux ARM
install_awscli_linux_arm() {
    # Install unzip if not already installed
    sudo apt-get update && sudo apt-get install -y unzip
    # Download AWS CLI installation package
    curl "https://awscli.amazonaws.com/awscli-exe-linux-arm64.zip" -o "awscliv2.zip"
    # Unzip the package
    unzip awscliv2.zip
    # Run the installation script
    sudo ./aws/install
}

# Check Linux OS architecture
if [ "$(uname -m)" == "x86_64" ]; then
    # Install AWS CLI for Linux x86 (64-bit)
    install_awscli_linux_x86_64
elif [ "$(uname -m)" == "aarch64" ]; then
    # Install AWS CLI for Linux ARM
    install_awscli_linux_arm
else
    echo "Unsupported Linux architecture. Please install AWS CLI manually."
    exit 1
fi
