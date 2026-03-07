#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y curl wget apt-transport-https ca-certificates gnupg lsb-release

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

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install Kubernetes
echo "Installing Kubernetes components..."

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | \
sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize Kubernetes cluster
echo "Initializing Kubernetes cluster..."

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel networking
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# Allow scheduling on control plane
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Verify cluster
kubectl get nodes
kubectl get pods -n kube-system

# Create storage directory
echo "Creating persistent storage directory..."

sudo mkdir -p /mnt/data
sudo chmod 777 /mnt/data

echo "Initial data from host" | sudo tee /mnt/data/host-file.txt

# Create PersistentVolume
cat <<EOF > pv-storage.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv
spec:
  storageClassName: manual
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
  persistentVolumeReclaimPolicy: Retain
EOF

kubectl apply -f pv-storage.yaml
kubectl get pv

# Create PersistentVolumeClaim
cat <<EOF > pvc-storage.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
EOF

kubectl apply -f pvc-storage.yaml
kubectl get pvc

# Pod using PVC
cat <<EOF > pod-with-pvc.yaml
apiVersion: v1
kind: Pod
metadata:
  name: storage-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    volumeMounts:
    - name: storage-volume
      mountPath: /usr/share/nginx/html
  volumes:
  - name: storage-volume
    persistentVolumeClaim:
      claimName: local-pvc
EOF

kubectl apply -f pod-with-pvc.yaml

kubectl wait --for=condition=Ready pod/storage-pod --timeout=120s

# Verify storage mount
kubectl exec storage-pod -- ls /usr/share/nginx/html
kubectl exec storage-pod -- cat /usr/share/nginx/html/host-file.txt

# Create data inside pod
kubectl exec storage-pod -- bash -c 'echo "Hello from Kubernetes PV" > /usr/share/nginx/html/index.html'

# Verify data on host
ls /mnt/data

# Restart pod to test persistence
kubectl delete pod storage-pod
kubectl apply -f pod-with-pvc.yaml

kubectl wait --for=condition=Ready pod/storage-pod --timeout=120s

kubectl exec storage-pod -- cat /usr/share/nginx/html/index.html

# Cleanup
kubectl delete pod storage-pod --ignore-not-found
kubectl get pv
kubectl get pvc
