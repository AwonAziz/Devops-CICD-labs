#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install base tools
sudo apt install -y curl wget git vim nano unzip software-properties-common build-essential

# Install Python
sudo apt install -y python3 python3-pip python3-venv

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install Docker
sudo apt install -y apt-transport-https ca-certificates gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install Buildkite Agent
curl -fsSL https://apt.buildkite.com/buildkite-agent/gpg.key | sudo apt-key add -

echo "deb https://apt.buildkite.com/buildkite-agent stable main" | \
sudo tee /etc/apt/sources.list.d/buildkite-agent.list

sudo apt update
sudo apt install -y buildkite-agent

# Install testing tools
pip3 install pytest pytest-cov flake8 black bandit safety

sudo npm install -g jest eslint prettier

# Create project directory
mkdir -p ~/cicd-pipeline-lab
cd ~/cicd-pipeline-lab

# Initialize git
git init
git config user.name "CI/CD Lab User"
git config user.email "user@cicdlab.local"

# Create project structure
mkdir -p src/backend src/frontend
mkdir -p tests/unit tests/integration tests/e2e
mkdir -p scripts config deployment
mkdir -p .buildkite

echo "Project structure created."
