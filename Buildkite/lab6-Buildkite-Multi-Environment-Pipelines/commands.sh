#!/bin/bash

# Update system
sudo apt update

# Install Docker
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Install Git
sudo apt install -y git

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install Buildkite Agent
echo "deb https://apt.buildkite.com/buildkite-agent stable main" \
| sudo tee /etc/apt/sources.list.d/buildkite-agent.list

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
--recv-keys 32A37959C2FA5C3C99EFBC32A79206696452D198

sudo apt update
sudo apt install -y buildkite-agent

# Create project directory
mkdir buildkite-multi-env-demo
cd buildkite-multi-env-demo

# Initialize Node project
npm init -y
npm install express dotenv

# Build Docker image
docker build -t myapp:latest .

# Test deployment scripts
.buildkite/scripts/deploy.sh dev
.buildkite/scripts/verify.sh

# Initialize git repo
git init
git add .
git commit -m "Initial commit"

git checkout -b develop
git checkout -b feature/multi-env-pipeline
git checkout main
