This lab demonstrates how to connect **Grafana** to multiple monitoring data sources including **Prometheus** and **InfluxDB**. The goal is to build a simple monitoring stack and verify that Grafana can collect and visualize metrics from different systems.

## Overview

In this lab we:

- Installed and configured **Prometheus** for metrics collection
- Installed **InfluxDB** as a time-series database
- Installed **Grafana** for visualization
- Connected Grafana to both Prometheus and InfluxDB
- Created a simple dashboard to test queries

This setup represents a basic **modern monitoring stack** commonly used in **DevOps and SRE environments**.

## Technologies Used

- Grafana
- Prometheus
- InfluxDB
- Linux (systemd services)

## Architecture


Prometheus ----
---> Grafana Dashboards
InfluxDB ------/


Prometheus collects system metrics while InfluxDB stores time-series data. Grafana connects to both sources to visualize the data.

## Key Steps

1. Install and configure Prometheus
2. Install and configure InfluxDB
3. Install Grafana
4. Connect Grafana to Prometheus
5. Connect Grafana to InfluxDB
6. Create dashboards to test data queries

## Example Queries

Prometheus:


up
prometheus_config_last_reload_successful


InfluxDB:


SELECT * FROM cpu_usage
SELECT mean(value) FROM memory_usage GROUP BY host


## Result

After completing the lab:

- Grafana successfully connects to both data sources
- Metrics from Prometheus can be queried and visualized
- Data stored in InfluxDB can be displayed in Grafana dashboards
