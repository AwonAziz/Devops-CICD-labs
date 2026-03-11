#!/bin/bash

# ===============================
# TASK 1 – SYSTEM SETUP
# ===============================

sudo apt update && sudo apt upgrade -y

sudo apt install -y curl wget git vim unzip \
software-properties-common apt-transport-https \
ca-certificates gnupg lsb-release build-essential


# ===============================
# INSTALL DOCKER
# ===============================

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker $USER

sudo systemctl start docker
sudo systemctl enable docker

docker --version


# ===============================
# INSTALL DOCKER COMPOSE
# ===============================

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version


# ===============================
# INSTALL FLY CLI
# ===============================

mkdir -p ~/concourse
cd ~/concourse

curl -L https://github.com/concourse/concourse/releases/latest/download/fly-linux-amd64 -o fly

chmod +x fly

sudo mv fly /usr/local/bin/

fly --version


# ===============================
# TASK 2 – SETUP CONCOURSE
# ===============================

mkdir -p ~/concourse-lab
cd ~/concourse-lab

mkdir keys

ssh-keygen -t rsa -b 4096 -f ./keys/session_signing_key -N ''
ssh-keygen -t rsa -b 4096 -f ./keys/tsa_host_key -N ''
ssh-keygen -t rsa -b 4096 -f ./keys/worker_key -N ''

chmod 600 keys/*

docker-compose up -d

sleep 30

docker-compose ps


# ===============================
# LOGIN TO CONCOURSE
# ===============================

fly -t tutorial login -c http://localhost:8080 -u admin -p admin

fly -t tutorial teams


# ===============================
# TASK 3 – CREATE SAMPLE APP
# ===============================

mkdir -p ~/sample-app
cd ~/sample-app

git init

git config user.email "student@example.com"
git config user.name "Lab Student"


# ===============================
# COMMIT PROJECT
# ===============================

git add .
git commit -m "Initial commit"


# ===============================
# TASK 4 – SET PIPELINE
# ===============================

cd ~/concourse-lab

fly -t tutorial set-pipeline -p sample-cicd -c simple-pipeline.yml

fly -t tutorial unpause-pipeline -p sample-cicd

fly -t tutorial unpause-job -j sample-cicd/build-test-deploy


# ===============================
# TASK 5 – TRIGGER PIPELINE
# ===============================

fly -t tutorial trigger-job -j sample-cicd/build-test-deploy

fly -t tutorial watch -j sample-cicd/build-test-deploy


# ===============================
# TASK 6 – VERIFY DEPLOYMENT
# ===============================

docker ps

curl http://localhost:3001/health
curl http://localhost:3002/health
curl http://localhost:3003/health


# ===============================
# CHECK PIPELINE STATUS
# ===============================

fly -t tutorial pipelines

fly -t tutorial builds -j sample-cicd/continuous-integration


# ===============================
# TEST FAILURE HANDLING
# ===============================

cd ~/sample-app

git add .
git commit -m "Test pipeline change"


# ===============================
# FINAL PIPELINE
# ===============================

cd ~/concourse-lab

fly -t tutorial set-pipeline -p sample-cicd -c final-pipeline.yml

fly -t tutorial unpause-pipeline -p sample-cicd

fly -t tutorial unpause-job -j sample-cicd/full-cicd-pipeline


# ===============================
# VERIFY APPLICATIONS
# ===============================

docker ps

curl http://localhost:3001/health
curl http://localhost:3002/health
curl http://localhost:3003/health
