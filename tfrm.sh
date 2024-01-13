#!/bin/bash

# Remove HashiCorp GPG key
sudo rm /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Remove HashiCorp repository
sudo rm /etc/apt/sources.list.d/hashicorp.list

# Update package list
sudo apt update

# Uninstall Terraform
sudo apt remove terraform

# Clean up unused dependencies
sudo apt autoremove

# Optionally, remove residual configuration files
# sudo rm -rf ~/.terraform

echo "Terraform has been successfully removed from your system."

