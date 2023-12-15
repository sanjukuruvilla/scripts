#!/bin/bash

# Display initial message
echo "Installing Kubernetes + Minikube for Debian distribution"

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or using sudo."
    exit 1
fi

# Set non-interactive environment variable
export DEBIAN_FRONTEND=noninteractive

# Update apt package index and install necessary packages
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Download the public signing key for the Kubernetes package repositories
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes apt repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

# Update apt package index again
apt-get update

# Install kubectl
apt-get install -y kubectl

# Download and install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube

# Create an alias for kubectl to use Minikube's version
alias kubectl="minikube kubectl --"
echo 'alias kubectl="minikube kubectl --"' >> ~/.bashrc
source ~/.bashrc


# Display completion message
echo "Installation of Kubernetes + Minikube completed"
echo "Use command 'kubectl cluster-info' to verify kubectl is correctly configured"
echo "Start Minikube cluster"
echo "run '$minikube start' "
