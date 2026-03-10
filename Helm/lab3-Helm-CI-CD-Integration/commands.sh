#!/bin/bash

# =========================================
# Lab 13 – Helm CI/CD Integration
# Command Reference
# =========================================

# -----------------------
# System Update
# -----------------------

sudo apt update && sudo apt upgrade -y

sudo apt install -y curl wget git unzip software-properties-common \
apt-transport-https ca-certificates gnupg lsb-release

# -----------------------
# Install Docker
# -----------------------

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker

docker --version

# -----------------------
# Install Kind (Kubernetes in Docker)
# -----------------------

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64

chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

kind --version

# -----------------------
# Install kubectl
# -----------------------

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client

# -----------------------
# Install Helm
# -----------------------

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

# -----------------------
# Create Kubernetes Cluster
# -----------------------

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
  - containerPort: 443
    hostPort: 443
  - containerPort: 8080
    hostPort: 8080
EOF

kind create cluster --config=kind-config.yaml --name=helm-cicd

kubectl cluster-info
kubectl get nodes

# -----------------------
# Install Java and Jenkins
# -----------------------

sudo apt install -y openjdk-11-jdk

java -version

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ \
> /etc/apt/sources.list.d/jenkins.list'

sudo apt update
sudo apt install -y jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

sudo systemctl status jenkins

# Get Jenkins initial password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# -----------------------
# Configure Jenkins Access
# -----------------------

sudo usermod -aG docker jenkins

sudo mkdir -p /var/lib/jenkins/.kube
sudo cp ~/.kube/config /var/lib/jenkins/.kube/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.kube

sudo systemctl restart jenkins

# -----------------------
# Create Demo Application
# -----------------------

mkdir -p ~/helm-cicd-demo
cd ~/helm-cicd-demo

# Initialize Helm chart
helm create helm-cicd-demo-chart

# -----------------------
# Build Docker Image
# -----------------------

docker build -t helm-cicd-demo:latest .

# Load image into Kind cluster
kind load docker-image helm-cicd-demo:latest --name=helm-cicd

# -----------------------
# Test Helm Chart
# -----------------------

helm lint ./helm-cicd-demo-chart

helm install test-release ./helm-cicd-demo-chart --dry-run --debug

# -----------------------
# Deploy Application
# -----------------------

helm install demo-app ./helm-cicd-demo-chart

kubectl get pods
kubectl get services

# Test application
kubectl port-forward service/demo-app-helm-cicd-demo-chart 8081:80 &

curl http://localhost:8081

# Cleanup port-forward
pkill -f "kubectl port-forward"

# -----------------------
# Initialize Git Repository
# -----------------------

git init

git config user.email "student@example.com"
git config user.name "Student"

git add .
git commit -m "Initial commit: Helm CI/CD demo project"

# Create Git branches
git checkout -b develop
git checkout -b staging
git checkout main

# -----------------------
# Jenkins Pipeline
# -----------------------

# Create Jenkinsfile
touch Jenkinsfile

git add Jenkinsfile
git commit -m "Add Jenkins pipeline configuration"

# -----------------------
# Verify Jenkins Access
# -----------------------

sudo -u jenkins kubectl get nodes
sudo -u jenkins helm version

# -----------------------
# Cleanup
# -----------------------

helm uninstall demo-app

kind delete cluster --name=helm-cicd
