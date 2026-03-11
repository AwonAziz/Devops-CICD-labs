#!/bin/bash

# SYSTEM SETUP
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git vim docker.io docker-compose postgresql-client

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

# PROJECT SETUP
mkdir -p ~/devops-lab
cd ~/devops-lab
mkdir -p concourse/{keys,web,worker}
mkdir -p sample-app
mkdir -p monitoring

# GENERATE KEYS
cd ~/devops-lab/concourse/keys
ssh-keygen -t rsa -f host_key -N ''
ssh-keygen -t rsa -f worker_key -N ''
ssh-keygen -t rsa -f session_signing_key -N ''
chmod 600 *

# START INFRASTRUCTURE
cd ~/devops-lab
docker-compose up -d
sleep 30
docker-compose ps

# INSTALL FLY CLI
curl -L https://github.com/concourse/concourse/releases/download/v7.9.1/fly-7.9.1-linux-amd64.tgz -o fly.tgz
tar -xzf fly.tgz
sudo mv fly /usr/local/bin/
chmod +x /usr/local/bin/fly

# LOGIN
fly -t tutorial login -c http://localhost:8080 -u admin -p admin

# SET PIPELINE
fly -t tutorial set-pipeline -p devops-workflow -c ~/devops-lab/pipeline.yml
fly -t tutorial unpause-pipeline -p devops-workflow

# TRIGGER JOB
fly -t tutorial trigger-job -j devops-workflow/test-code

# BUILD IMAGE
cd ~/devops-lab/sample-app
docker build -t localhost:5000/sample-app:latest .
docker push localhost:5000/sample-app:latest

# DEPLOY
docker-compose -f docker-compose.app.yml up -d

# VERIFY
curl http://localhost:5001/
curl http://localhost:5001/health
curl http://localhost:5001/metrics
