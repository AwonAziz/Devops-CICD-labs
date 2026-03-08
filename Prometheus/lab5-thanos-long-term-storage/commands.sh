```bash
#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y wget curl unzip docker.io docker-compose

# Enable docker
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER
newgrp docker

# Create working directories
mkdir -p ~/thanos-lab/{prometheus,thanos,storage}
cd ~/thanos-lab

# Install Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
tar -xzf prometheus-2.47.0.linux-amd64.tar.gz
mv prometheus-2.47.0.linux-amd64 prometheus-install

sudo cp prometheus-install/prometheus /usr/local/bin/
sudo cp prometheus-install/promtool /usr/local/bin/

# Create prometheus user
sudo useradd --no-create-home --shell /bin/false prometheus

sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus

# Install Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar -xzf node_exporter-1.6.1.linux-amd64.tar.gz
sudo cp node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/

# Start node exporter
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Install Thanos
wget https://github.com/thanos-io/thanos/releases/download/v0.32.4/thanos-0.32.4.linux-amd64.tar.gz
tar -xzf thanos-0.32.4.linux-amd64.tar.gz
sudo cp thanos-0.32.4.linux-amd64/thanos /usr/local/bin/

# Verify installation
thanos --version

# Install MinIO
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
sudo mv minio /usr/local/bin/

mkdir -p ~/thanos-lab/storage/minio-data

# Start MinIO
cd ~/thanos-lab/storage
nohup minio server minio-data --address :9000 --console-address :9001 > minio.log 2>&1 &

sleep 10

# Install MinIO client
cd ~/thanos-lab
wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
sudo mv mc /usr/local/bin/

# Configure client
mc alias set local http://localhost:9000 minioadmin minioadmin

# Create bucket
mc mb local/thanos-bucket

# Check bucket
mc ls local/

# Test Thanos Query API
curl http://localhost:10904/api/v1/query?query=up

# Check ports
netstat -tlnp | grep -E "(9090|9100|10901|10902|10903|10904|10905|10906|10907|9000)"
