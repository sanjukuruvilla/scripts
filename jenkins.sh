#!/bin/bash

if command -v apt &>/dev/null; then
    # For Debian/Ubuntu
    sudo apt update -y
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc
    echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
    sudo apt update -y
    sudo apt install temurin-17-jdk -y
    sudo apt-get update -y
    sudo apt-get install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl status jenkins
elif command -v yum &>/dev/null; then
    # For CentOS/RHEL
    echo "Jenkins installation is not supported on CentOS/RHEL via package manager. Please install Jenkins manually."
    exit 1
else
    echo "Unsupported package manager. Please install Jenkins manually."
    exit 1
fi
