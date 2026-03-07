echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s \
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install kind (Kubernetes in Docker)
echo "Installing kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/kind

# Install Helm
echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Verify installations
docker --version
kubectl version --client
kind version
helm version

# Create Kubernetes cluster
echo "Creating Kubernetes cluster..."

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --config=kind-config.yaml --name=disaster-recovery-lab

kubectl cluster-info
kubectl get nodes

# Deploy MinIO for backup storage
echo "Deploying MinIO..."

kubectl create namespace minio

cat <<EOF > minio-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minio
  namespace: minio
spec:
  replicas: 1
  selector:
    matchLabels:
      app: minio
  template:
    metadata:
      labels:
        app: minio
    spec:
      containers:
      - name: minio
        image: minio/minio:latest
        args:
        - server
        - /data
        env:
        - name: MINIO_ROOT_USER
          value: minioadmin
        - name: MINIO_ROOT_PASSWORD
          value: minioadmin123
        ports:
        - containerPort: 9000
EOF

kubectl apply -f minio-deployment.yaml
kubectl get pods -n minio

# Install MinIO client
echo "Installing MinIO client..."

wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
sudo mv mc /usr/local/bin/

# Configure MinIO
mc alias set local http://localhost:30000 minioadmin minioadmin123
mc mb local/velero-backups

# Install Velero CLI
echo "Installing Velero..."

wget https://github.com/vmware-tanzu/velero/releases/download/v1.12.1/velero-v1.12.1-linux-amd64.tar.gz
tar -xzf velero-v1.12.1-linux-amd64.tar.gz
sudo mv velero-v1.12.1-linux-amd64/velero /usr/local/bin/

velero version --client-only

# Create Velero credentials
cat <<EOF > credentials-velero
[default]
aws_access_key_id=minioadmin
aws_secret_access_key=minioadmin123
EOF

# Install Velero in cluster
velero install \
--provider aws \
--plugins velero/velero-plugin-for-aws:v1.8.1 \
--bucket velero-backups \
--secret-file ./credentials-velero \
--use-volume-snapshots=false \
--backup-location-config \
region=minio,s3ForcePathStyle="true",s3Url=http://minio-service.minio.svc.cluster.local:9000

kubectl get pods -n velero

# Create test namespace
kubectl create namespace test-app

# Create backup
echo "Creating Velero backup..."
velero backup create test-app-backup --include-namespaces test-app

velero backup get

# Simulate disaster
echo "Simulating disaster..."
kubectl delete namespace test-app

# Restore from backup
echo "Restoring backup..."
velero restore create restore-test --from-backup test-app-backup

velero restore get
