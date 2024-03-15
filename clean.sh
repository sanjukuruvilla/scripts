#!/bin/bash

# Function to check if the OS is Debian/Ubuntu
is_debian() {
    command -v apt &>/dev/null
}

# Function to check if the OS is CentOS/RHEL
is_centos() {
    command -v yum &>/dev/null
}

# Remove Docker
remove_docker() {
    echo "Removing Docker..."
    sudo apt-get purge docker-ce docker-ce-cli containerd.io -y
    sudo rm -rf /var/lib/docker
}

# Remove Minikube
remove_minikube() {
    echo "Removing Minikube..."
    sudo minikube delete
}

# Remove Jenkins
remove_jenkins() {
    echo "Removing Jenkins..."
    sudo systemctl stop jenkins
    sudo apt-get purge jenkins -y
}

# Remove kubectl
remove_kubectl() {
    echo "Removing kubectl..."
    sudo rm -rf /usr/local/bin/kubectl
}

# Remove Python
remove_python() {
    echo "Removing Python..."
    sudo apt-get purge python3 python3-pip -y
}

# Remove AWS CLI
remove_awscli() {
    echo "Removing AWS CLI..."
    sudo apt-get purge awscli -y
}

# System cleanup
system_cleanup() {
    echo "Performing system cleanup..."
    if is_debian; then
        sudo apt-get autoremove --purge -y
        sudo apt-get clean
        sudo apt-get autoclean
    elif is_centos; then
        sudo yum autoremove -y
        sudo yum clean all
    else
        echo "Unsupported package manager. Please clean the system manually."
        exit 1
    fi
    echo "System cleanup completed."
}

# Main script
echo "Starting removal process..."

remove_docker
remove_minikube
remove_jenkins
remove_kubectl
remove_python
remove_awscli
system_cleanup

echo "All packages removed and system cleaned."
