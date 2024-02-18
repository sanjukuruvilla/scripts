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

# Function to install required dependencies
function install_dependencies {
    echo "Installing required dependencies..."
    sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get install -y zip unzip
    check_command "Dependency installation"
}

# Function to install Docker and add user to the docker group
function install_docker {
    echo "Installing Docker..."
    sudo apt-get update -y && sudo apt-get install -y docker.io
    check_command "Docker installation"
    
    # Add user to the docker group
    sudo usermod -aG docker $USER
    newgrp docker
}

# Function to install Java (Java 17 or above)
function install_java {
    echo "Installing Java..."
    sudo apt-get update -y && sudo apt-get install -y openjdk-17-jdk
    check_command "Java installation"
}

# Function to install Jenkins
function install_jenkins {
    echo "Installing Jenkins..."
    sudo wget -q -O /usr/share/keyrings/jenkins-keyring.asc \
        https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update -y && sudo apt-get install -y jenkins
    check_command "Jenkins installation"
}

# Function to install Kubectl without user interaction
function install_kubectl_auto {
    echo "Installing Kubectl..."
    
    # Step 1: Install prerequisites
    sudo apt-get update -y && sudo apt-get install -y apt-transport-https ca-certificates curl
    
    # Step 2: Add Kubernetes apt-keyring
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    
    # Step 3: Add Kubernetes repository
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    
    # Step 4: Update and install Kubectl
    sudo apt-get update -y && sudo apt-get install -y kubectl
    check_command "Kubectl installation"
}

# Function to install Minikube and start it
function install_minikube {
    echo "Do you want to install Minikube for Kubernetes? (yes/no)"
    read install_minikube_choice

    if [ "$install_minikube_choice" = "yes" ] || [ "$install_minikube_choice" = "y" ]; then
        echo "Installing Minikube..."
        curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube-linux-amd64 /usr/local/bin/minikube
        check_command "Minikube installation"
        
        # Start Minikube
        sudo minikube start
    else
        echo "Skipping Minikube installation."
    fi
}

# Function to install Terraform
function install_terraform {
    echo "Do you want to install the latest version of Terraform? (yes/no)"
    read install_latest_terraform_choice

    if [ "$install_latest_terraform_choice" = "yes" ] || [ "$install_latest_terraform_choice" = "y" ]; then
        echo "Downloading the latest version of Terraform..."
        wget https://releases.hashicorp.com/terraform/1.7.3/terraform_1.7.3_linux_amd64.zip -O /tmp/terraform.zip
        sudo unzip -d /usr/local/bin/ /tmp/terraform.zip
        rm /tmp/terraform.zip
        check_command "Latest Terraform installation"
        echo "Latest version of Terraform installed successfully."
    else
        echo "Skipping installation of the latest version of Terraform."
    fi
}

# Function to install latest AWS CLI
function install_aws_cli {
    echo "Installing the latest version of AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip ./aws
    check_command "AWS CLI installation"
    echo "Latest version of AWS CLI installed successfully."
}

# Function to install Python
function install_python {
    echo "Installing Python..."
    sudo apt-get update -y && sudo apt-get install -y python3
    check_command "Python installation"
    echo "Python installed successfully."
}

# Main script

# Install required dependencies
install_dependencies

# Install Docker and add user to the docker group
install_docker

# Install Java
install_java

# Install Jenkins
install_jenkins

# Install Kubectl
install_kubectl_auto

# Install Minikube (optional)
install_minikube

# Install Terraform (optional)
install_terraform

echo "Installation completed successfully."
