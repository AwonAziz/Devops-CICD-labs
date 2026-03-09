#!/bin/bash

# =========================
# System Setup
# =========================

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common git


# =========================
# Install Docker
# =========================

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y docker-ce

sudo usermod -aG docker $USER
newgrp docker

docker --version


# =========================
# Install kubectl
# =========================

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client


# =========================
# Install Kind
# =========================

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/kind

kind version


# =========================
# Install ArgoCD CLI
# =========================

curl -sSL -o argocd-linux-amd64 \
https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

argocd version --client


# =========================
# Create Kind Cluster
# =========================

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
EOF

kind create cluster --config=kind-config.yaml --name=argocd-lab

kubectl cluster-info --context kind-argocd-lab


# =========================
# Install ArgoCD
# =========================

kubectl create namespace argocd

kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


kubectl wait \
--for=condition=available \
--timeout=300s \
deployment/argocd-server \
-n argocd


# =========================
# Access ArgoCD
# =========================

kubectl port-forward svc/argocd-server -n argocd 8080:443 &

ARGOCD_PASSWORD=$(kubectl -n argocd \
get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d)

echo "ArgoCD Admin Password: $ARGOCD_PASSWORD"


# =========================
# Login to ArgoCD CLI
# =========================

argocd login localhost:8080 \
--username admin \
--password $ARGOCD_PASSWORD \
--insecure


# =========================
# Create GitOps Repository
# =========================

mkdir -p ~/gitops-demo/apps/nginx-app
cd ~/gitops-demo

git init

git config user.name "Lab User"
git config user.email "lab@example.com"


# =========================
# Deploy Application via ArgoCD
# =========================

kubectl apply -f nginx-app.yaml


# =========================
# Verify Deployment
# =========================

argocd app list
kubectl get pods


# =========================
# Cleanup
# =========================

kind delete cluster --name argocd-lab

rm -rf ~/gitops-demo
