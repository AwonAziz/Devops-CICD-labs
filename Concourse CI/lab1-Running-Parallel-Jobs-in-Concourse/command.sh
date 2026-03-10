```bash
#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install tools
sudo apt install -y wget curl docker.io docker-compose git nano

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Create concourse directory
mkdir ~/concourse-lab4
cd ~/concourse-lab4

# Create docker compose file
nano docker-compose.yml

# Start concourse
docker-compose up -d

# Wait for startup
sleep 120

# Download fly CLI
wget http://localhost:8080/api/v1/cli?arch=amd64\&platform=linux -O fly

# Install fly
chmod +x fly
sudo mv fly /usr/local/bin/

# Verify fly
fly --version

# Login to concourse
fly -t tutorial login -c http://localhost:8080 -u admin -p admin

# Create project directory
mkdir -p ~/parallel-jobs-lab/{pipelines,scripts,resources}
cd ~/parallel-jobs-lab

# Create pipeline file
nano pipelines/parallel-jobs-pipeline.yml

# Set pipeline
fly -t tutorial set-pipeline -p parallel-jobs -c pipelines/parallel-jobs-pipeline.yml

# Unpause pipeline
fly -t tutorial unpause-pipeline -p parallel-jobs

# Trigger pipeline
fly -t tutorial trigger-job -j parallel-jobs/initialize-pipeline

# Check jobs
fly -t tutorial jobs -p parallel-jobs
