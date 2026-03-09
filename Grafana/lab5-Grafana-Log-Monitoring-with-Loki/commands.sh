#!/bin/bash

# ==============================
# System Update
# ==============================

sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl unzip software-properties-common apt-transport-https


# ==============================
# Install Loki
# ==============================

sudo mkdir -p /opt/loki
cd /opt/loki

wget https://github.com/grafana/loki/releases/download/v2.9.2/loki-linux-amd64.zip
unzip loki-linux-amd64.zip

sudo chmod +x loki-linux-amd64
sudo mv loki-linux-amd64 /usr/local/bin/loki

loki --version


# ==============================
# Configure Loki
# ==============================

sudo mkdir -p /etc/loki

sudo tee /etc/loki/loki.yml > /dev/null <<EOF
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  path_prefix: /tmp/loki
  storage:
    filesystem:
      chunks_directory: /tmp/loki/chunks
      rules_directory: /tmp/loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h
EOF


# ==============================
# Create Loki Service
# ==============================

sudo tee /etc/systemd/system/loki.service > /dev/null <<EOF
[Unit]
Description=Loki service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/loki -config.file /etc/loki/loki.yml
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable loki
sudo systemctl start loki

sudo systemctl status loki


# ==============================
# Install Promtail
# ==============================

cd /opt

sudo wget https://github.com/grafana/loki/releases/download/v2.9.2/promtail-linux-amd64.zip
sudo unzip promtail-linux-amd64.zip

sudo chmod +x promtail-linux-amd64
sudo mv promtail-linux-amd64 /usr/local/bin/promtail

promtail --version


# ==============================
# Configure Promtail
# ==============================

sudo mkdir -p /etc/promtail

sudo tee /etc/promtail/promtail.yml > /dev/null <<EOF
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://localhost:3100/loki/api/v1/push

scrape_configs:
  - job_name: system
    static_configs:
      - targets:
          - localhost
        labels:
          job: varlogs
          __path__: /var/log/*log

  - job_name: syslog
    static_configs:
      - targets:
          - localhost
        labels:
          job: syslog
          __path__: /var/log/syslog

  - job_name: auth
    static_configs:
      - targets:
          - localhost
        labels:
          job: auth
          __path__: /var/log/auth.log
EOF


# ==============================
# Promtail Service
# ==============================

sudo tee /etc/systemd/system/promtail.service > /dev/null <<EOF
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/promtail -config.file /etc/promtail/promtail.yml
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable promtail
sudo systemctl start promtail

sudo systemctl status promtail


# ==============================
# Install Grafana
# ==============================

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "deb https://packages.grafana.com/oss/deb stable main" \
| sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt update
sudo apt install -y grafana

sudo systemctl enable grafana-server
sudo systemctl start grafana-server

sudo systemctl status grafana-server


# ==============================
# Verify Services
# ==============================

sudo netstat -tlnp | grep -E "3100|9080|3000"


# ==============================
# Access Grafana
# ==============================

echo "Grafana: http://localhost:3000"
echo "Default login: admin / admin"
