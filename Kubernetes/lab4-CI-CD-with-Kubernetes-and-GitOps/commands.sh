echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing required packages..."
sudo apt install -y curl wget git vim nano software-properties-common \
apt-transport-https ca-certificates gnupg lsb-release

# Install Docker
echo "Installing Docker..."

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker

docker --version

# Install kubectl
echo "Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Minikube
echo "Installing Minikube..."

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start --driver=docker

kubectl cluster-info
kubectl get nodes

# Install Java for Jenkins
echo "Installing Java..."
sudo apt install -y openjdk-11-jdk

# Install Jenkins
echo "Installing Jenkins..."

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install -y jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

# Retrieve Jenkins admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Install ArgoCD
echo "Installing ArgoCD..."

kubectl create namespace argocd

kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=available deployment/argocd-server \
-n argocd --timeout=300s

# Get ArgoCD admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d && echo

# Create project directories
mkdir -p ~/cicd-lab/sample-app
mkdir -p ~/cicd-lab/k8s-manifests

# Initialize Git repository
cd ~/cicd-lab
git init

git config user.name "Lab Student"
git config user.email "student@example.com"

# Build Docker image
cd ~/cicd-lab/sample-app
docker build -t sample-app:latest .

# Test container locally
docker run -d -p 3000:3000 --name test-app sample-app:latest

sleep 5

curl http://localhost:3000/
curl http://localhost:3000/health

docker stop test-app
docker rm test-app

# Deploy application to Kubernetes
kubectl apply -f ~/cicd-lab/k8s-manifests/namespace.yaml
kubectl apply -f ~/cicd-lab/k8s-manifests/ -n sample-app

kubectl get pods -n sample-app
kubectl get services -n sample-app

# Test service
kubectl port-forward svc/sample-app-service 3001:80 -n sample-app &

sleep 5
curl http://localhost:3001/
curl http://localhost:3001/health

# Check ArgoCD applications
argocd app list
