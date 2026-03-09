#!/bin/bash

# =========================
# Prometheus Installation
# =========================

sudo useradd --no-create-home --shell /bin/false prometheus

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

cd /tmp

wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz

tar xvf prometheus-2.47.0.linux-amd64.tar.gz
cd prometheus-2.47.0.linux-amd64

sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/

sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus

sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

# Create Prometheus config manually
sudo nano /etc/prometheus/prometheus.yml

# Reload and start service
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

curl http://localhost:9090/metrics


# =========================
# InfluxDB Installation
# =========================

wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -

echo "deb https://repos.influxdata.com/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/influxdb.list

sudo apt update

sudo apt install influxdb -y

sudo systemctl enable influxdb
sudo systemctl start influxdb

curl -i http://localhost:8086/ping


# =========================
# InfluxDB Sample Data
# =========================

influx

CREATE DATABASE grafana_lab
USE grafana_lab

INSERT cpu_usage,host=server1,region=us-west value=80.5
INSERT cpu_usage,host=server2,region=us-east value=65.2

INSERT memory_usage,host=server1,region=us-west value=75.8
INSERT memory_usage,host=server2,region=us-east value=82.1

SELECT * FROM cpu_usage
SELECT * FROM memory_usage

exit


# =========================
# Grafana Installation
# =========================

sudo apt-get install -y software-properties-common

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "deb https://packages.grafana.com/oss/deb stable main" \
| sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install grafana -y

sudo systemctl enable grafana-server
sudo systemctl start grafana-server

curl http://localhost:3000


# =========================
# Verification
# =========================

sudo systemctl status prometheus
sudo systemctl status influxdb
sudo systemctl status grafana-server

sudo netstat -tlnp | grep -E "(3000|8086|9090)"
