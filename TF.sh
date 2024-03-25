#!/bin/bash

# Function to install Terraform on Debian-based systems
install_terraform_debian() {
    # Update package lists
    sudo apt update
    # Install unzip utility
    sudo apt install -y unzip
    # Download latest version of Terraform
    TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    # Unzip Terraform binary
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    # Move Terraform binary to /usr/local/bin directory
    sudo mv terraform /usr/local/bin/
    # Verify installation
    terraform --version
}

# Function to install Terraform on RHEL-based systems
install_terraform_rhel() {
    # Install EPEL repository
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    # Install unzip utility
    sudo yum install -y unzip
    # Download latest version of Terraform
    TERRAFORM_VERSION=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    # Unzip Terraform binary
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    # Move Terraform binary to /usr/local/bin directory
    sudo mv terraform /usr/local/bin/
    # Verify installation
    terraform --version
}

# Check Linux OS version
if [ -f /etc/debian_version ]; then
    # Debian-based system
    install_terraform_debian
elif [ -f /etc/redhat-release ]; then
    # RHEL-based system
    install_terraform_rhel
elif grep -qi "Amazon Linux" /etc/system-release; then
    # Amazon Linux
    install_terraform_rhel
else
    echo "Unsupported Linux distribution. Please install Terraform manually."
    exit 1
fi

