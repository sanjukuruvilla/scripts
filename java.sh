#!/bin/bash

if command -v apt &>/dev/null; then
    # For Debian/Ubuntu
    echo "Installing Java..."
    sudo apt-get update -y && sudo apt-get install -y -q openjdk-17-jdk
    echo "Java installation completed."
elif command -v yum &>/dev/null; then
    # For CentOS/RHEL
    echo "Java installation is not supported on CentOS/RHEL via package manager. Please install Java manually."
    exit 1
else
    echo "Unsupported package manager. Please install Java manually."
    exit 1
fi
