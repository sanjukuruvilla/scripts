#!/bin/bash

echo "Installing Minikube..."
if command -v apt &>/dev/null; then
    # For Debian/Ubuntu
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
elif command -v yum &>/dev/null; then
    # For CentOS/RHEL
    echo "Minikube installation is not supported on CentOS/RHEL via package manager. Please install Minikube manually."
    exit 1
else
    echo "Unsupported package manager. Please install Minikube manually."
    exit 1
fi
