#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl tar systemd

echo "Creating Prometheus user..."
sudo useradd --no-create-home --shell /bin/false prometheus

echo "Creating directories..."
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

echo "Downloading Prometheus..."
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz
tar xvf prometheus-2.47.0.linux-amd64.tar.gz
cd prometheus-2.47.0.linux-amd64

echo "Installing Prometheus binaries..."
sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/

sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus

echo "Creating Prometheus configuration..."
sudo tee /etc/prometheus/prometheus.yml > /dev/null <<EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']
EOF

echo "Creating Prometheus service..."
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus

[Install]
WantedBy=multi-user.target
EOF

echo "Installing Node Exporter..."
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar xvf node_exporter-1.6.1.linux-amd64.tar.gz
sudo cp node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/

echo "Creating Node Exporter service..."
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

echo "Starting services..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl enable node_exporter
sudo systemctl start prometheus
sudo systemctl start node_exporter

echo "Checking Prometheus metrics..."
curl http://localhost:9090/api/v1/label/__name__/values

echo "Example PromQL queries..."

echo "Check service status:"
curl -s "http://localhost:9090/api/v1/query?query=up"

echo "Memory metrics:"
curl -s "http://localhost:9090/api/v1/query?query=node_memory_MemTotal_bytes"

echo "CPU metrics:"
curl -s "http://localhost:9090/api/v1/query?query=node_cpu_seconds_total"

echo "Prometheus setup and query environment ready."
