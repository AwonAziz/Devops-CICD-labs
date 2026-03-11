#!/bin/bash

# ==========================
# TASK 1 – SYSTEM SETUP
# ==========================

sudo apt update && sudo apt upgrade -y

sudo apt install -y curl wget apt-transport-https \
ca-certificates gnupg lsb-release software-properties-common


# ==========================
# INSTALL DOCKER
# ==========================

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker

docker --version


# ==========================
# INSTALL KUBECTL
# ==========================

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

kubectl version --client


# ==========================
# INSTALL MINIKUBE
# ==========================

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube version


# ==========================
# START KUBERNETES CLUSTER
# ==========================

minikube start --driver=docker --memory=4096 --cpus=2

minikube status

kubectl cluster-info

kubectl get nodes


# ==========================
# INSTALL DOCKER COMPOSE
# ==========================

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version


# ==========================
# SETUP CONCOURSE
# ==========================

mkdir -p ~/concourse-lab
cd ~/concourse-lab

mkdir -p keys/web keys/worker

ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''

cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
cp ./keys/web/tsa_host_key.pub ./keys/worker/


# ==========================
# START CONCOURSE
# ==========================

docker-compose up -d

sleep 30

docker-compose ps


# ==========================
# INSTALL FLY CLI
# ==========================

curl -L http://localhost:8080/api/v1/cli?arch=amd64&platform=linux -o fly

chmod +x fly

sudo mv fly /usr/local/bin/

fly -t tutorial login -c http://localhost:8080 -u admin -p admin

fly -t tutorial workers


# ==========================
# CREATE APPLICATION
# ==========================

mkdir -p ~/k8s-app
cd ~/k8s-app


# ==========================
# BUILD IMAGE
# ==========================

docker build -t web-app:latest .

minikube image load web-app:latest

minikube image ls | grep web-app


# ==========================
# INIT GIT REPO
# ==========================

git init

git config user.name "Lab User"
git config user.email "lab@example.com"

git add .
git commit -m "Initial commit"


# ==========================
# APPLY K8S MANIFESTS
# ==========================

kubectl apply -f k8s-manifests/

kubectl get deployments

kubectl get pods

kubectl get services


# ==========================
# VERIFY APPLICATION
# ==========================

kubectl rollout status deployment/web-app

curl http://$(minikube ip):30080


# ==========================
# PIPELINE COMMANDS
# ==========================

fly -t tutorial pipelines

fly -t tutorial trigger-job -j k8s-monitoring/deploy-to-k8s --watch


# ==========================
# MONITOR CLUSTER
# ==========================

kubectl get deployments

kubectl get pods -o wide

kubectl get services


# ==========================
# CLEANUP
# ==========================

kubectl delete -f ~/k8s-app/k8s-manifests/

cd ~/concourse-lab
docker-compose down

minikube stop

docker system prune -f
