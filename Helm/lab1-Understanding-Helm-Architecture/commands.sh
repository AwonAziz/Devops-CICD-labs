#!/bin/bash


# -----------------------
# System Update
# -----------------------

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget apt-transport-https ca-certificates gnupg lsb-release

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

# -----------------------
# Install kubectl
# -----------------------

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# -----------------------
# Install Minikube
# -----------------------

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# -----------------------
# Install Helm
# -----------------------

curl https://baltocdn.com/helm/signing.asc | \
gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] \
https://baltocdn.com/helm/stable/debian/ all main" | \
sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt update
sudo apt install -y helm

helm version

# -----------------------
# Start Kubernetes Cluster
# -----------------------

minikube start --driver=docker

kubectl cluster-info
kubectl get nodes

# -----------------------
# Create Helm Chart
# -----------------------

mkdir ~/helm-lab
cd ~/helm-lab

helm create my-first-chart

find my-first-chart -type f | sort

cat my-first-chart/Chart.yaml
cat my-first-chart/values.yaml

# -----------------------
# Render Templates
# -----------------------

helm template my-first-chart ./my-first-chart

helm template my-first-chart ./my-first-chart --set replicaCount=3

# -----------------------
# Custom Values File
# -----------------------

cat > custom-values.yaml <<EOF
replicaCount: 2
image:
  repository: nginx
  tag: "1.21"
service:
  type: NodePort
  port: 8080
EOF

helm template my-first-chart ./my-first-chart -f custom-values.yaml

# -----------------------
# Chart Dependencies
# -----------------------

helm create webapp-with-db
cd webapp-with-db

helm repo add bitnami https://charts.bitnami.com/bitnami

helm dependency update

helm dependency list

# -----------------------
# Helm Repositories
# -----------------------

helm repo list

helm repo add stable https://charts.helm.sh/stable
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update

helm search repo nginx
helm search repo mysql

# -----------------------
# Download Chart
# -----------------------

cd ~/helm-lab

helm pull bitnami/nginx

tar -xzf nginx-*.tgz

# -----------------------
# Create Local Repository
# -----------------------

helm package my-first-chart

mkdir ~/local-helm-repo

mv my-first-chart-*.tgz ~/local-helm-repo/

cd ~/local-helm-repo

helm repo index . --url http://localhost:8080

python3 -m http.server 8080 &

helm repo add local http://localhost:8080
helm repo update

# -----------------------
# Helm CLI Operations
# -----------------------

helm install my-nginx bitnami/nginx

helm list

helm get values my-nginx

helm upgrade my-nginx bitnami/nginx --set replicaCount=2

helm history my-nginx

helm rollback my-nginx 1

helm uninstall my-nginx

# -----------------------
# Deploy Fullstack Chart
# -----------------------

cd ~/helm-lab

helm create fullstack-app
cd fullstack-app

helm dependency update

helm lint .

helm install fullstack-release .

kubectl get pods
kubectl get services

helm uninstall fullstack-release
