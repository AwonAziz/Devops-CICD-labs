#!/bin/bash


# ----------------
# System Setup
# ----------------

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git unzip jq apt-transport-https ca-certificates gnupg lsb-release

# ----------------
# Install Docker
# ----------------

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

# ----------------
# Install Kubernetes Tools
# ----------------

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

kubectl version --client
kind version

# ----------------
# Create Kubernetes Cluster
# ----------------

kind create cluster --name argocd-secrets-lab

kubectl cluster-info
kubectl get nodes

# ----------------
# Install Argo CD
# ----------------

kubectl create namespace argocd

kubectl apply -n argocd -f \
https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=300s

kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d

kubectl port-forward svc/argocd-server -n argocd 8080:443

# ----------------
# Create Demo Namespace
# ----------------

kubectl create namespace demo-app

# ----------------
# Create Kubernetes Secret
# ----------------

kubectl create secret generic app-secrets \
--from-literal=database-url="postgresql://user:password@db:5432/myapp" \
--from-literal=api-key="super-secret-api-key" \
--from-literal=jwt-secret="jwt-signing-key" \
-n demo-app

kubectl get secrets -n demo-app

# ----------------
# Deploy Demo Application
# ----------------

kubectl apply -f demo-app-deployment.yaml

kubectl get pods -n demo-app
kubectl get services -n demo-app

# ----------------
# Create GitOps Repository
# ----------------

mkdir -p ~/argocd-secrets-demo
cd ~/argocd-secrets-demo

git init
git config user.name "Lab User"
git config user.email "user@lab.local"

git add .
git commit -m "Initial commit"

# ----------------
# Create Argo CD Application
# ----------------

kubectl apply -f argocd-application.yaml
kubectl get applications -n argocd

# ----------------
# Install HashiCorp Vault
# ----------------

wget https://releases.hashicorp.com/vault/1.15.2/vault_1.15.2_linux_amd64.zip
unzip vault_1.15.2_linux_amd64.zip

sudo mv vault /usr/local/bin/

vault version

# ----------------
# Start Vault
# ----------------

vault server -dev

export VAULT_ADDR='http://127.0.0.1:8200'

# ----------------
# Install External Secrets Operator
# ----------------

kubectl apply -f \
https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/crds/bundle.yaml

kubectl apply -f \
https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/charts/external-secrets/templates/deployment.yaml

kubectl get pods -n external-secrets-system

# ----------------
# Apply External Secrets
# ----------------

kubectl apply -f external-secret-database.yaml
kubectl apply -f external-secret-api.yaml
kubectl apply -f external-secret-jwt.yaml

kubectl get externalsecrets -n demo-app
kubectl get secrets -n demo-app

# ----------------
# Restart Deployment After Secret Rotation
# ----------------

kubectl rollout restart deployment/demo-app-vault -n demo-app
kubectl rollout status deployment/demo-app-vault -n demo-app

# ----------------
# Troubleshooting
# ----------------

kubectl logs -n external-secrets-system deployment/external-secrets
kubectl describe externalsecret database-secret -n demo-app
kubectl get events -n demo-app
