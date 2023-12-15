#!/bin/bash

# Update the package list
sudo apt update

# Install OpenJDK 17
sudo apt install -y openjdk-17-jdk

# Download and install Jenkins GPG key
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# Add Jenkins repository to the package sources
echo "deb http://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

# Update the package list to include Jenkins
sudo apt update

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Display Jenkins initial admin password
echo "Waiting for Jenkins to start..."
sleep 30  # Wait for Jenkins to start (you can adjust the time as needed)

JENKINS_PASSWORD_FILE="/var/lib/jenkins/secrets/initialAdminPassword"
if [ -f "$JENKINS_PASSWORD_FILE" ]; then
    echo "Jenkins initial admin password:"
    cat "$JENKINS_PASSWORD_FILE"
else
    echo "Error: Jenkins initial admin password not found."
fi

# Provide Jenkins URL
echo "Jenkins URL: http://localhost:8080"

# End of script

