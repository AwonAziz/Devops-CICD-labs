```bash
#!/bin/bash

# =========================
# Update System
# =========================

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release


# =========================
# Install Docker
# =========================

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

newgrp docker

docker --version


# =========================
# Install kubectl
# =========================

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client


# =========================
# Install kind
# =========================

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64

chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

kind version


# =========================
# Create Kubernetes Cluster
# =========================

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --config=kind-config.yaml --name=rollouts-lab

kubectl cluster-info
kubectl get nodes


# =========================
# Install Argo Rollouts
# =========================

kubectl create namespace argo-rollouts

kubectl apply -n argo-rollouts \
-f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

kubectl get pods -n argo-rollouts


# =========================
# Install Argo Rollouts CLI Plugin
# =========================

curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64

chmod +x kubectl-argo-rollouts-linux-amd64

sudo mv kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

kubectl argo rollouts version


# =========================
# Create Canary Deployment
# =========================

kubectl create namespace canary-demo

kubectl apply -f canary-rollout.yaml
kubectl apply -f canary-service.yaml

kubectl get pods -n canary-demo


# =========================
# Trigger Canary Update
# =========================

kubectl argo rollouts set image rollouts-demo \
rollouts-demo=argoproj/rollouts-demo:yellow -n canary-demo

kubectl argo rollouts get rollout rollouts-demo -n canary-demo --watch


# =========================
# Blue Green Deployment
# =========================

kubectl create namespace bluegreen-demo

kubectl apply -f bluegreen-rollout.yaml
kubectl apply -f bluegreen-active-service.yaml
kubectl apply -f bluegreen-preview-service.yaml

kubectl get pods -n bluegreen-demo


# =========================
# Promote Blue Green Release
# =========================

kubectl argo rollouts promote rollout-bluegreen -n bluegreen-demo


# =========================
# Rollback Example
# =========================

kubectl argo rollouts undo rollouts-demo -n canary-demo


# =========================
# Cleanup
# =========================

kubectl delete namespace canary-demo
kubectl delete namespace bluegreen-demo
kubectl delete namespace argo-rollouts

kind delete cluster --name rollouts-lab
