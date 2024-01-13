#!/bin/bash

# Function to display error messages
function error_exit {
    echo "Error: $1" >&2
    exit 1
}

# Function to check if the command was successful
function check_command {
    if [ $? -ne 0 ]; then
        error_exit "Failed to execute: $1"
    fi
}

# Function to install Docker
function install_docker {
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    check_command "Docker installation"
}

# Function to install Java (Java 17 or above)
function install_java {
    echo "Installing Java..."
    sudo apt-get install -y openjdk-17-jdk
    check_command "Java installation"
}

# Function to install Jenkins
function install_jenkins {
    echo "Installing Jenkins..."
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
        https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y jenkins
    check_command "Jenkins installation"
}

# Function to install Kubectl
function install_kubectl {
    echo "Installing Kubectl..."
    sudo apt-get update
    sudo apt-get install -y kubectl
    check_command "Kubectl installation"
}

# Function to install Minikube
function install_minikube {
    echo "Do you want to install Minikube for Kubernetes? (yes/no)"
    read install_minikube_choice

    if [ "$install_minikube_choice" = "yes" ] || [ "$install_minikube_choice" = "y" ]; then
        echo "Installing Minikube..."
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        check_command "Minikube installation"
    else
        echo "Skipping Minikube installation."
    fi
}

# Function to install Terraform
function install_terraform {
    echo "Do you want to install Terraform? (yes/no)"
    read install_terraform_choice

    if [ "$install_terraform_choice" = "yes" ] || [ "$install_terraform_choice" = "y" ]; then
        echo "Installing Terraform..."
        wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip -O /tmp/terraform.zip
        sudo unzip -d /usr/local/bin/ /tmp/terraform.zip
        rm /tmp/terraform.zip
        check_command "Terraform installation"
    else
        echo "Skipping Terraform installation."
    fi
}

# Main script

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    error_exit "This script must be run as root. Please use sudo."
fi

# Install Docker
install_docker

# Install Java
install_java

# Install Jenkins
install_jenkins

# Install Kubectl
install_kubectl

# Install Minikube (optional)
install_minikube

# Install Terraform (optional)
install_terraform

echo "Installation completed successfully."

