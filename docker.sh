#!/bin/bash

if command -v apt &>/dev/null; then
    # For Debian/Ubuntu
    sudo apt-get update -y
    sudo apt-get install docker.io -y
    sudo usermod -aG docker $USER
    newgrp docker
    sudo chmod 777 /var/run/docker.sock
elif command -v yum &>/dev/null; then
    # For CentOS/RHEL
    sudo yum update -y
    sudo yum install docker -y
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Unsupported package manager. Please install Docker manually."
    exit 1
fi
