#!/bin/bash
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER
newgrp docker
