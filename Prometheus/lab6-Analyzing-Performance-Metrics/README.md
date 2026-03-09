This lab focuses on building a complete **system performance monitoring stack** using Prometheus and Grafana.

Prometheus collects system metrics while Grafana provides dashboards to visualize CPU, memory, disk, and network performance. PromQL queries are used to analyze system behavior and identify potential bottlenecks.

## Technologies Used
- Prometheus
- Grafana
- Node Exporter
- PromQL
- Linux / Systemd

## Monitoring Architecture
Node Exporter → exposes system metrics  
Prometheus → collects and stores metrics  
Grafana → visualizes metrics using dashboards

## Key Metrics Analyzed
The monitoring stack tracks several important system metrics:

- CPU utilization
- Memory usage
- Disk usage
- Network traffic
- System load averages
- Context switches
- Network errors and dropped packets

## Example PromQL Queries

CPU Usage


100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)


Memory Usage


(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100


Disk Usage


100 - ((node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"}) * 100)


## Dashboards Created
Several Grafana dashboards were created to visualize system performance:

### System Overview Dashboard
- CPU usage
- Memory utilization
- Disk usage

### CPU Monitoring Dashboard
- CPU usage per core
- CPU usage by mode
- Load averages
- Context switches

### Network Monitoring Dashboard
- Network throughput
- Packet rates
- Network errors

## Alerting Rules
Prometheus alerts were configured for:

- High CPU usage (>80%)
- High memory usage (>85%)
- Low disk space (>90%)

These alerts help identify system performance problems early.

## Generating Test Load
System activity was generated to observe metrics:

- CPU load using `stress-ng`
- Memory allocation tests
- Disk I/O operations
- Network downloads

## Skills Demonstrated
- Infrastructure monitoring setup
- Prometheus configuration
- Writing PromQL queries
- Grafana dashboard creation
- System performance analysis
- Alert rule configuration

## Web Interfaces
| Service | URL |
|------|------|
Prometheus | http://localhost:9090 |
Grafana | http://localhost:3000 |
Node Exporter | http://localhost:9100 |

Default Grafana login:
username: admin
password: admin
