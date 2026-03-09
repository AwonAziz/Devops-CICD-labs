This lab demonstrates how to query system monitoring data using **PromQL (Prometheus Query Language)** and visualize the results using **Grafana dashboards**.

The goal is to build a small monitoring stack and use PromQL queries to analyze system metrics such as CPU usage, memory usage, disk usage, and network traffic.

## Overview

In this lab we:

- Installed **Prometheus** for metrics collection
- Installed **Node Exporter** to gather system metrics
- Installed **Grafana** for visualization
- Wrote **PromQL queries** to analyze system performance
- Built dashboards displaying system metrics
- Tested advanced PromQL functions and aggregations

## Technologies Used

- Prometheus
- Node Exporter
- Grafana
- PromQL
- Linux (systemd services)

## Monitoring Architecture


Node Exporter ---> Prometheus ---> Grafana
(System Metrics) (Storage) (Dashboards)


Node Exporter collects system metrics.  
Prometheus scrapes and stores the metrics.  
Grafana queries Prometheus using PromQL to visualize the data.

## Example PromQL Queries

### CPU Usage

100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)


### Memory Usage

(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100


### Disk Usage

100 - ((node_filesystem_avail_bytes{mountpoint="/"} /
node_filesystem_size_bytes{mountpoint="/"}) * 100)


### Network Traffic

rate(node_network_receive_bytes_total{device!="lo"}[5m])


### Load Average

node_load1


## Dashboard Panels Created

- CPU Usage
- Memory Usage
- Network Traffic
- Disk Usage
- System Load Average

## Result

After completing the lab:

- Prometheus successfully collects system metrics from Node Exporter
- PromQL queries retrieve meaningful monitoring data
- Grafana dashboards display real-time system performance metrics
