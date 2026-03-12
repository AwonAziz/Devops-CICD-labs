#!/bin/bash

# ================================
# LAB 5 - HYBRID CLOUD PIPELINE
# ================================

# Update system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y \
curl wget git unzip \
software-properties-common \
apt-transport-https \
ca-certificates \
gnupg \
lsb-release

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor \
-o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker

docker --version

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt install -y nodejs

node --version
npm --version

# Create project structure
mkdir -p ~/buildkite-hybrid-lab
cd ~/buildkite-hybrid-lab

mkdir -p agents pipelines apps configs scripts
mkdir -p environments/cloud environments/onpremise

# Download Buildkite agent
wget https://github.com/buildkite/agent/releases/latest/download/buildkite-agent-linux-amd64.tar.gz

tar -xzf buildkite-agent-linux-amd64.tar.gz
mv buildkite-agent-linux-amd64 buildkite-agent
chmod +x buildkite-agent/buildkite-agent

# Create agent directories
mkdir -p agents/cloud-agent
mkdir -p agents/onpremise-agent

echo "Setup completed"
