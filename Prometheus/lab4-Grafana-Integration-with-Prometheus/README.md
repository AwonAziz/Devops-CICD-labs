This lab demonstrates how to integrate **Grafana with Prometheus** to create visual monitoring dashboards for system metrics.

Grafana was installed and configured on a Linux system, then connected to **Prometheus as a data source**. Using PromQL queries, multiple dashboard panels were created to visualize key metrics such as CPU usage, memory utilization, disk usage, network traffic, and system load.

The lab highlights how Grafana transforms raw monitoring data into **interactive dashboards for real-time infrastructure monitoring**.

---

## Skills Practiced

- Installing and configuring Grafana on Linux
- Connecting Grafana to Prometheus as a data source
- Creating dashboards and panels
- Writing PromQL queries for visualization
- Configuring gauges, stats, and time-series charts
- Using dashboard variables for dynamic filtering
- Importing community dashboards
- Designing monitoring dashboards following best practices

---

## Technologies Used

- Grafana
- Prometheus
- Node Exporter
- PromQL
- Linux
- systemd

---

## Example Metrics Visualized

Check service status:


up


CPU usage percentage:


100 - (avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)


Memory usage percentage:


(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100


Disk usage percentage:


100 - ((node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100)


Network traffic rate:


rate(node_network_receive_bytes_total{device!="lo"}[5m])


System load metrics:


node_load1
node_load5
node_load15


---

## What I Learned

Through this lab I learned how **Prometheus and Grafana work together to provide a complete monitoring stack**.

Prometheus collects and stores metrics, while Grafana provides powerful visualization capabilities through customizable dashboards. This combination is widely used in modern DevOps environments to monitor infrastructure, detect issues early, and analyze performance trends.
