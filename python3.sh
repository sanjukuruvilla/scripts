#!/bin/bash

# Function to install Python3
install_python3() {
    echo "Installing Python3..."
    if command -v apt &>/dev/null; then
        # Update package lists
        sudo apt update

        # Install Python3
        sudo apt install -y python3
    elif command -v yum &>/dev/null; then
        # Install Python3
        sudo yum install -y python3
    else
        echo "Unsupported operating system. Please install Python3 manually."
        exit 1
    fi
}

# Main script
echo "Welcome to Python3 installation script!"
install_python3
echo "Python3 installation completed."
