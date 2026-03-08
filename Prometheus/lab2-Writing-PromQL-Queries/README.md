This lab focuses on learning **PromQL (Prometheus Query Language)**, the powerful query language used by Prometheus to retrieve and analyze monitoring data.

A Prometheus monitoring environment was deployed on a Linux system and used to explore how metrics can be queried, filtered, aggregated, and analyzed using PromQL.

The lab demonstrates how monitoring data can be transformed into actionable insights for **system monitoring, alerting, and performance analysis**.

---

## Skills Practiced

- Writing basic PromQL queries
- Filtering metrics using labels
- Performing aggregations across multiple time series
- Using rate and increase functions for counter metrics
- Applying mathematical operations to monitoring data
- Creating reusable scripts for Prometheus queries
- Building query libraries for monitoring dashboards

---

## Technologies Used

- Prometheus
- Node Exporter
- PromQL
- Linux
- systemd
- Bash scripting

---

## Example PromQL Queries

Check if services are running:


up


CPU usage percentage:


100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)


Memory usage percentage:


(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100


Network traffic rate:


rate(node_network_receive_bytes_total[5m])


Disk usage percentage:


(1 - (node_filesystem_free_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"})) * 100


---

## Key PromQL Features

| Feature | Purpose |
|------|------|
| Label filtering | Select specific metric series |
| Aggregation | Summarize metrics across systems |
| Rate functions | Measure change over time |
| Mathematical operations | Calculate percentages and trends |
| Regular expressions | Advanced metric filtering |

---

## What I Learned

Through this lab I learned how **PromQL enables deep visibility into system performance**.

Important takeaways:

- Prometheus stores metrics as time series data
- PromQL enables powerful filtering and aggregation
- Metrics can be transformed into real-time system insights
- Complex queries allow building monitoring dashboards and alerts
