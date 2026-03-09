#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Create Prometheus user
sudo useradd --no-create-home --shell /bin/false prometheus

# Create directories
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# Install Prometheus
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
tar xvf prometheus-2.45.0.linux-amd64.tar.gz
cd prometheus-2.45.0.linux-amd64

sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/

sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

# Copy console files
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

# Install Node Exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.0/node_exporter-1.6.0.linux-amd64.tar.gz
tar xvf node_exporter-1.6.0.linux-amd64.tar.gz
cd node_exporter-1.6.0.linux-amd64

sudo cp node_exporter /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/node_exporter

# Reload systemd and start services
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl start node_exporter
sudo systemctl enable prometheus
sudo systemctl enable node_exporter

# Install Grafana
sudo apt install -y software-properties-common

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "deb https://packages.grafana.com/oss/deb stable main" | \
sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt update
sudo apt install -y grafana

# Start Grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# Verify services
sudo systemctl status prometheus
sudo systemctl status node_exporter
sudo systemctl status grafana-server

# Install stress tool for testing
sudo apt install -y stress-ng

# Generate CPU load
stress-ng --cpu 2 --timeout 300s

# Generate memory load
stress-ng --vm 1 --vm-bytes 512M --timeout 300s

# Generate disk IO
dd if=/dev/zero of=/tmp/testfile bs=1M count=1000

# Generate network traffic
wget -O /tmp/testfile.iso http://releases.ubuntu.com/20.04/ubuntu-20.04.6-desktop-amd64.iso
