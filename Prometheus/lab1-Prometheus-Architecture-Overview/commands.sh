#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install wget curl tar -y

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

echo "Copying Prometheus configuration files..."
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus

echo "Creating Prometheus service..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

echo "Installing Node Exporter..."
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar xvf node_exporter-1.6.1.linux-amd64.tar.gz
cd node_exporter-1.6.1.linux-amd64
sudo cp node_exporter /usr/local/bin/

echo "Starting Node Exporter..."
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "Installing Process Exporter..."
cd /tmp
wget https://github.com/ncabatoff/process-exporter/releases/download/v0.7.10/process-exporter-0.7.10.linux-amd64.tar.gz
tar xvf process-exporter-0.7.10.linux-amd64.tar.gz
cd process-exporter-0.7.10.linux-amd64
sudo cp process-exporter /usr/local/bin/

echo "Starting Process Exporter..."
sudo systemctl daemon-reload
sudo systemctl enable process_exporter
sudo systemctl start process_exporter

echo "Installing Alertmanager..."
cd /tmp
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
tar xvf alertmanager-0.26.0.linux-amd64.tar.gz
cd alertmanager-0.26.0.linux-amd64
sudo cp alertmanager /usr/local/bin/
sudo cp amtool /usr/local/bin/

echo "Starting Alertmanager..."
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager

echo "Checking services..."
sudo systemctl status prometheus
sudo systemctl status node_exporter
sudo systemctl status process_exporter
sudo systemctl status alertmanager

echo "Testing metrics endpoints..."
curl http://localhost:9090/metrics | head
curl http://localhost:9100/metrics | head
curl http://localhost:9256/metrics | head

echo "Prometheus monitoring stack setup complete."
