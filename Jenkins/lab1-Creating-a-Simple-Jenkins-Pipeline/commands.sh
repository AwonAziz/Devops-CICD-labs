#!/bin/bash

# Update system
sudo apt update

# Install Java (required for Jenkins)
sudo apt install -y openjdk-11-jdk

# Verify Java installation
java -version

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update
sudo apt install -y jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check Jenkins status
sudo systemctl status jenkins

# Get Jenkins initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Install Git
sudo apt install -y git
git --version

# Configure Git
git config --global user.name "Jenkins User"
git config --global user.email "jenkins@example.com"

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js
node --version
npm --version

# Create project directory
mkdir -p ~/jenkins-demo
cd ~/jenkins-demo

# Initialize Node.js project
npm init -y

# Install testing dependency
npm install mocha --save-dev

# Initialize Git repository
git init

# Create .gitignore
echo "node_modules/" > .gitignore

# Add project files
git add .
git commit -m "Initial commit: Jenkins pipeline demo"

# Change permissions for Jenkins
sudo chown -R jenkins:jenkins ~/jenkins-demo
sudo chmod -R 755 ~/jenkins-demo

# Verify repository
git status
git log --oneline

# Test application manually
npm start &
sleep 3
curl http://localhost:3000
pkill -f "node app.js"
