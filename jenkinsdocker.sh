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

# Create a bridge network in Docker
docker network create jenkins
check_command "Creating Docker network"

# Run docker:dind image to enable Docker in Docker
docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind --storage-driver overlay2
check_command "Running Docker in Docker"

# Customize the official Jenkins Docker image
cat <<EOF > Dockerfile
FROM jenkins/jenkins:2.426.2-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=\$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  \$(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
EOF

# Build a new docker image
docker build -t myjenkins-blueocean:2.426.2-1 .
check_command "Building Jenkins Docker image"

# Run Jenkins Docker container
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.426.2-1
check_command "Running Jenkins Docker container"

echo "Jenkins installation and Docker setup completed successfully."

