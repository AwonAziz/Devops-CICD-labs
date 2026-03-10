#!/bin/bash

# ===============================
# System Preparation
# ===============================

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git vim unzip


# ===============================
# Install Docker
# ===============================

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker $USER
newgrp docker

docker --version


# ===============================
# Install kubectl
# ===============================

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client


# ===============================
# Install Minikube
# ===============================

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start --driver=docker --memory=4096 --cpus=2

kubectl cluster-info
kubectl get nodes


# ===============================
# Install Argo CD
# ===============================

kubectl create namespace argocd

kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait \
--for=condition=available \
--timeout=300s \
deployment/argocd-server \
-n argocd

kubectl get pods -n argocd


# ===============================
# Access Argo CD
# ===============================

kubectl port-forward svc/argocd-server -n argocd 8080:443 &

ARGOCD_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d)

echo "ArgoCD Admin Password: $ARGOCD_PASS"


# ===============================
# Install Argo CD CLI
# ===============================

curl -sSL -o argocd-linux-amd64 \
https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

rm argocd-linux-amd64


# ===============================
# Login to Argo CD
# ===============================

argocd login localhost:8080 \
--username admin \
--password $ARGOCD_PASS \
--insecure


# ===============================
# Create GitOps Repository
# ===============================

mkdir ~/argocd-demo-app
cd ~/argocd-demo-app

git init


# ===============================
# Create Kubernetes Deployment
# ===============================

cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: demo-app
  template:
    metadata:
      labels:
        app: demo-app
    spec:
      containers:
      - name: demo-app
        image: nginx:1.21
        ports:
        - containerPort: 80
EOF


# ===============================
# Commit to Git
# ===============================

git add .
git commit -m "Initial demo app deployment"


# ===============================
# Create Argo CD Application
# ===============================

argocd app create demo-app \
--repo https://github.com/YOUR_USERNAME/argocd-demo-app.git \
--path . \
--dest-server https://kubernetes.default.svc \
--dest-namespace default \
--sync-policy automated \
--auto-prune \
--self-heal


# ===============================
# Deploy Application
# ===============================

argocd app sync demo-app

kubectl get pods


# ===============================
# Test Application
# ===============================

kubectl port-forward svc/demo-app-service 8081:80 &

curl http://localhost:8081


# ===============================
# Cleanup
# ===============================

argocd app delete demo-app --cascade

pkill -f "kubectl port-forward"
