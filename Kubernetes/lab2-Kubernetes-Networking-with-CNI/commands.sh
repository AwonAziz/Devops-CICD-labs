#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing Docker..."
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER

echo "Installing Kubernetes components..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

echo "Configuring system settings for Kubernetes..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

echo "Initializing Kubernetes cluster..."
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --skip-phases=addon/kube-proxy

mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/control-plane-

echo "Installing Calico CNI..."
curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml -O
kubectl apply -f calico.yaml

kubectl get pods -n kube-system | grep calico

echo "Creating test pods..."

cat <<EOF > pod1.yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod-1
  labels:
    app: test-pod-1
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
EOF

kubectl apply -f pod1.yaml

cat <<EOF > pod2.yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod-2
  labels:
    app: test-pod-2
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sleep","3600"]
EOF

kubectl apply -f pod2.yaml

kubectl get pods -o wide

echo "Getting pod IP addresses..."
POD1_IP=$(kubectl get pod test-pod-1 -o jsonpath='{.status.podIP}')
POD2_IP=$(kubectl get pod test-pod-2 -o jsonpath='{.status.podIP}')

echo "Testing pod connectivity..."
kubectl exec test-pod-2 -- ping -c 3 $POD1_IP

echo "Creating service..."

cat <<EOF > service1.yaml
apiVersion: v1
kind: Service
metadata:
  name: test-service-1
spec:
  selector:
    app: test-pod-1
  ports:
  - port: 80
    targetPort: 80
EOF

kubectl apply -f service1.yaml

echo "Testing service DNS..."
kubectl exec test-pod-2 -- nslookup test-service-1.default.svc.cluster.local

echo "Creating network policy..."

cat <<EOF > network-policy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
spec:
  podSelector:
    matchLabels:
      app: test-pod-1
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: test-pod-2
    ports:
    - protocol: TCP
      port: 80
EOF

kubectl apply -f network-policy.yaml

kubectl get networkpolicy

echo "Lab networking setup complete."
