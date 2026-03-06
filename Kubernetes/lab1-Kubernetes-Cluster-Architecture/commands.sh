echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl gpg

echo "Disabling swap (required for Kubernetes)..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "Installing container runtime (containerd)..."
sudo apt install -y containerd

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd

echo "Installing Kubernetes components..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update

sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable kubelet

echo "Initializing Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

echo "Configuring kubectl for current user..."
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Installing Flannel network plugin..."
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

kubectl taint nodes --all node-role.kubernetes.io/control-plane-

echo "Checking cluster status..."
kubectl cluster-info
kubectl get nodes
kubectl get pods -A

echo "Inspecting Kubernetes control plane components..."
kubectl get pods -n kube-system

echo "Checking kubelet service..."
sudo systemctl status kubelet

echo "Checking container runtime..."
sudo systemctl status containerd

echo "Viewing kubelet logs..."
sudo journalctl -u kubelet --no-pager | tail -20

echo "Creating test deployment..."
kubectl create deployment test-nginx --image=nginx:latest

kubectl scale deployment test-nginx --replicas=3

kubectl get pods
kubectl get events --sort-by=.metadata.creationTimestamp

echo "Cleaning up test deployment..."
kubectl delete deployment test-nginx
