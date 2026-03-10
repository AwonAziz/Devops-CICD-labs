#!/bin/bash

# Update system and install base tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget apt-transport-https ca-certificates gnupg lsb-release git

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Verify Docker
docker --version
docker run hello-world

# Install Java (required for Jenkins)
sudo apt install -y openjdk-11-jdk
java -version

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install -y jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

# Get Jenkins admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Add Jenkins user to Docker group
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

# Verify Jenkins Docker access
sudo -u jenkins docker ps

# Create project directory
mkdir -p ~/jenkins-docker-lab
cd ~/jenkins-docker-lab

# Initialize Git repository
git init
git config user.name "Jenkins Lab User"
git config user.email "jenkins@lab.local"

# Add project files
git add .
git commit -m "Initial commit: Jenkins Docker integration lab"

# Verify containers and images
docker ps
docker images

# Test deployed application
curl http://localhost:3000/
curl http://localhost:3000/health
