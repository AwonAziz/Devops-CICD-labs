#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Create kind cluster
cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
EOF

kind create cluster --config=kind-config.yaml --name=helm-debug-lab

# Verify cluster
kubectl cluster-info
kubectl get nodes

# Create Helm chart with issues
helm create problematic-app
cd problematic-app

# Debug Helm templates
helm lint .
helm template my-app . --debug

# Test installation
helm install my-problematic-app . --debug --dry-run

# Deploy application
helm install my-problematic-app . --debug --wait

# Check release status
helm status my-problematic-app
helm list
helm history my-problematic-app

# Kubernetes debugging
kubectl get pods
kubectl describe pods
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl logs -l app.kubernetes.io/instance=my-problematic-app

# Fix chart and upgrade
helm upgrade my-problematic-app . --debug --wait

# Run Helm tests
helm test my-problematic-app

# Rollback example
helm history my-problematic-app
helm rollback my-problematic-app 1

# Cleanup
helm uninstall my-problematic-app || true
kind delete cluster --name=helm-debug-lab
