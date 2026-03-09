#!/bin/bash

# ==============================
# System Update
# ==============================

sudo apt update && sudo apt upgrade -y


# ==============================
# Install Docker
# ==============================

sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker

docker --version


# ==============================
# Install kubectl
# ==============================

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client


# ==============================
# Install Minikube
# ==============================

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube version


# ==============================
# Start Kubernetes Cluster
# ==============================

minikube start --driver=docker --memory=4096 --cpus=2

minikube status
kubectl cluster-info


# ==============================
# Enable Metrics Server
# ==============================

minikube addons enable metrics-server
minikube addons list


# ==============================
# Create Monitoring Namespace
# ==============================

kubectl create namespace monitoring
kubectl get namespaces


# ==============================
# Deploy Prometheus
# ==============================

kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-rbac.yaml
kubectl apply -f prometheus-deployment.yaml


# ==============================
# Verify Prometheus
# ==============================

kubectl get deployments -n monitoring
kubectl get pods -n monitoring
kubectl get services -n monitoring

kubectl wait --for=condition=ready pod -l app=prometheus -n monitoring --timeout=300s


# ==============================
# Deploy Grafana
# ==============================

kubectl apply -f grafana-deployment.yaml

kubectl get deployments -n monitoring
kubectl get pods -n monitoring

kubectl wait --for=condition=ready pod -l app=grafana -n monitoring --timeout=300s


# ==============================
# Access Services
# ==============================

MINIKUBE_IP=$(minikube ip)

echo "Grafana: http://$MINIKUBE_IP:32000"
echo "Prometheus: http://$MINIKUBE_IP:30000"


# ==============================
# Optional Port Forwarding
# ==============================

kubectl port-forward -n monitoring service/grafana-service 3000:3000 &
kubectl port-forward -n monitoring service/prometheus-service 9090:8080 &


# ==============================
# Test Application Deployment
# ==============================

kubectl create deployment nginx-test --image=nginx --replicas=3
kubectl expose deployment nginx-test --port=80 --type=NodePort

kubectl get deployments
kubectl get pods


# ==============================
# Cleanup
# ==============================

# kubectl delete namespace monitoring
# kubectl delete deployment nginx-test
# kubectl delete service nginx-test
# minikube stop
# minikube delete
