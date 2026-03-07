echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Install Docker
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

# Install Kubernetes tools
echo "Installing Kubernetes components..."

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
https://apt.kubernetes.io/ kubernetes-xenial main" | \
sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Configure containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd

# Disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Initialize Kubernetes cluster
echo "Initializing cluster..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Configure kubectl
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel network plugin
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# Allow scheduling on control-plane (single node)
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Verify cluster
kubectl cluster-info
kubectl get nodes
kubectl get pods -n kube-system

# Create troubleshooting namespace
kubectl create namespace troubleshooting

# Deploy broken image workload
kubectl create deployment broken-image-app \
--image=nonexistent/broken-image \
-n troubleshooting

# Deploy resource heavy workload
kubectl create deployment resource-hungry-app \
--image=nginx \
-n troubleshooting

# Deploy web application
kubectl create deployment web-app \
--image=nginx \
-n troubleshooting

kubectl expose deployment web-app \
--port=80 \
--type=ClusterIP \
-n troubleshooting \
--name=broken-service

# Basic diagnostics
echo "Running cluster diagnostics..."

kubectl get nodes -o wide
kubectl describe nodes
kubectl get pods -n troubleshooting
kubectl get events --sort-by=.metadata.creationTimestamp

# Pod troubleshooting
kubectl describe pods -n troubleshooting
kubectl logs -n troubleshooting deployment/web-app

# Install metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Monitor resource usage
kubectl top nodes
kubectl top pods --all-namespaces

# Cleanup
echo "Cleaning up resources..."
kubectl delete namespace troubleshooting
