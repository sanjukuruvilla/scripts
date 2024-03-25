#!/bin/bash

# Function to install Terraform on Debian-based systems
install_terraform_debian() {
    # Add HashiCorp GPG key
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    # Add HashiCorp repository
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    # Update package lists and install Terraform
    sudo apt update && sudo apt install -y terraform
}

# Function to install Terraform on RHEL-based systems
install_terraform_rhel() {
    # Install yum-utils for yum-config-manager
    sudo yum install -y yum-utils
    # Add HashiCorp repository
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    # Install Terraform
    sudo yum -y install terraform
}

# Function to install Terraform on Amazon Linux
install_terraform_amazon_linux() {
    # Install yum-utils and shadow-utils
    sudo yum install -y yum-utils shadow-utils
    # Add HashiCorp repository
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    # Install Terraform
    sudo yum -y install terraform
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
    install_terraform_amazon_linux
else
    echo "Unsupported Linux distribution. Please install Terraform manually."
    exit 1
fi

