#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install base dependencies
sudo apt install -y wget curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Install Java (required for Jenkins)
sudo apt install -y openjdk-11-jdk
java -version
javac -version

# Set JAVA_HOME
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
source ~/.bashrc

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update
sudo apt install -y jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

# Get initial Jenkins admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Install Docker
sudo apt remove -y docker docker-engine docker.io containerd runc

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add users to docker group
sudo usermod -aG docker jenkins
sudo usermod -aG docker $USER

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Restart Jenkins to apply changes
sudo systemctl restart jenkins

# Verify Docker
docker --version
docker run hello-world

# Install Maven
cd /opt
sudo wget https://archive.apache.org/dist/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
sudo tar xzf apache-maven-3.9.4-bin.tar.gz
sudo ln -s apache-maven-3.9.4 maven

# Configure Maven environment
echo 'export M2_HOME=/opt/maven' | sudo tee -a /etc/environment
echo 'export MAVEN_HOME=/opt/maven' | sudo tee -a /etc/environment
echo 'export PATH=${M2_HOME}/bin:${PATH}' | sudo tee -a /etc/environment

source /etc/environment

# Create system link
sudo ln -s /opt/maven/bin/mvn /usr/local/bin/mvn

# Verify Maven
mvn -version

# Check Jenkins logs
sudo tail -f /var/log/jenkins/jenkins.log
