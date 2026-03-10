#!/bin/bash

# ----------------------
# System Update
# ----------------------

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# ----------------------
# Install Docker
# ----------------------

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
docker run hello-world

# ----------------------
# Install kubectl
# ----------------------

curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client

# ----------------------
# Install Minikube
# ----------------------

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start --driver=docker

kubectl cluster-info
kubectl get nodes

# ----------------------
# Install Helm
# ----------------------

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update
helm repo list

# ----------------------
# Search Helm Charts
# ----------------------

helm search repo nginx
helm search repo wordpress

helm show chart bitnami/nginx
helm show readme bitnami/nginx

# ----------------------
# Deploy NGINX with Helm
# ----------------------

kubectl create namespace helm-demo

helm install my-nginx bitnami/nginx --namespace helm-demo

helm status my-nginx --namespace helm-demo
helm list --namespace helm-demo

kubectl get all --namespace helm-demo

# ----------------------
# Access NGINX
# ----------------------

kubectl get svc --namespace helm-demo

kubectl port-forward --namespace helm-demo svc/my-nginx 8080:80 &

curl http://localhost:8080

# ----------------------
# Examine Helm Chart
# ----------------------

mkdir ~/helm-charts
cd ~/helm-charts

helm pull bitnami/nginx --untar

ls nginx
cat nginx/Chart.yaml
cat nginx/values.yaml
ls nginx/templates

# ----------------------
# Deploy with Custom Values
# ----------------------

helm install custom-nginx bitnami/nginx \
--namespace helm-demo \
--values custom-nginx-values.yaml

helm list --namespace helm-demo

kubectl get pods --namespace helm-demo
kubectl get svc --namespace helm-demo

# ----------------------
# Verify Deployment
# ----------------------

kubectl get deployment custom-nginx --namespace helm-demo

kubectl describe pod -l app.kubernetes.io/instance=custom-nginx \
--namespace helm-demo

minikube service custom-nginx --namespace helm-demo --url

# ----------------------
# Upgrade Release
# ----------------------

helm upgrade custom-nginx bitnami/nginx \
--namespace helm-demo \
--values updated-nginx-values.yaml

helm status custom-nginx --namespace helm-demo

helm history custom-nginx --namespace helm-demo

# ----------------------
# Rollback Release
# ----------------------

helm rollback custom-nginx 1 --namespace helm-demo

helm history custom-nginx --namespace helm-demo

# ----------------------
# Deploy WordPress
# ----------------------

helm install my-wordpress bitnami/wordpress \
--namespace helm-demo \
--values wordpress-values.yaml \
--timeout 10m

kubectl get pods --namespace helm-demo -w

helm status my-wordpress --namespace helm-demo

minikube service my-wordpress --namespace helm-demo --url

# ----------------------
# Inspect WordPress Resources
# ----------------------

kubectl get all --namespace helm-demo \
-l app.kubernetes.io/instance=my-wordpress

kubectl get secrets --namespace helm-demo
kubectl get configmaps --namespace helm-demo

kubectl describe deployment my-wordpress --namespace helm-demo

# ----------------------
# Cleanup
# ----------------------

helm uninstall my-nginx --namespace helm-demo
helm uninstall custom-nginx --namespace helm-demo
helm uninstall my-wordpress --namespace helm-demo

kubectl delete namespace helm-demo

minikube stop
minikube delete
