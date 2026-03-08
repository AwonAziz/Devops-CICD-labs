This lab introduces the **core architecture of Prometheus** and demonstrates how a full monitoring stack can be built on a Linux server.

The environment was configured by installing the Prometheus server, multiple exporters for metrics collection, and Alertmanager for handling alerts. After deployment, the Prometheus web interface was used to query metrics using **PromQL** and monitor system health.

---

## Key Concepts Practiced

- Prometheus monitoring architecture
- Installing and configuring Prometheus server
- Collecting system metrics using exporters
- Configuring Alertmanager for alert handling
- Writing and testing PromQL queries
- Monitoring services through the Prometheus Web UI

---

## Technologies Used

- Prometheus
- Node Exporter
- Process Exporter
- Alertmanager
- PromQL
- Linux
- systemd

---

## Architecture Overview

Prometheus monitoring consists of several key components:
Exporters (Node / Process)
│
▼
Prometheus Server
│
▼
Alertmanager
│
▼
Alerts & Notifications


- **Exporters** collect system metrics.
- **Prometheus** scrapes and stores metrics.
- **Alertmanager** processes and routes alerts.
- **PromQL** allows querying and analyzing metrics.

---

## Services and Ports

| Component | Port | Purpose |
|-----------|------|--------|
| Prometheus | 9090 | Metrics collection and web UI |
| Node Exporter | 9100 | System metrics |
| Process Exporter | 9256 | Process monitoring |
| Alertmanager | 9093 | Alert handling |

---

## Example PromQL Queries

Check service health:


up


CPU usage:


100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)


Memory usage:


(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100


Network traffic:


rate(node_network_receive_bytes_total[5m])


---

## What I Learned

This lab demonstrated how the **Prometheus monitoring ecosystem works as a complete observability stack**.

Key takeaways:

- Prometheus collects metrics through exporters
- Alertmanager processes and manages alerts
- PromQL enables flexible metric analysis
- The Prometheus UI provides real-time monitoring visibility
