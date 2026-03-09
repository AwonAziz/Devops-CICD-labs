This lab demonstrates how to configure **proactive monitoring and alerting** using Prometheus, Grafana, Node Exporter, and Alertmanager.

The objective is to build a monitoring stack capable of detecting system issues and automatically sending notifications when thresholds are exceeded.

## Overview

In this lab we:

- Installed **Prometheus** for metrics collection
- Installed **Node Exporter** to collect system metrics
- Installed **Grafana** for monitoring dashboards
- Installed **Alertmanager** for alert routing and notifications
- Created alert rules for CPU, memory, disk, and service availability
- Configured alert notifications (email / Slack)
- Tested alerts using CPU and memory stress tests

## Monitoring Architecture


Node Exporter → Prometheus → Alertmanager → Notifications
↓
Grafana
(Dashboards)


- **Node Exporter** collects system metrics
- **Prometheus** scrapes and stores metrics
- **Alertmanager** manages alert notifications
- **Grafana** visualizes metrics and dashboards

## Example Alert Rules

### High CPU Usage


100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80


Triggers when CPU usage exceeds **80% for 2 minutes**.

### High Memory Usage


(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100 > 85


Triggers when memory usage exceeds **85%**.

### Low Disk Space


(1 - (node_filesystem_avail_bytes / node_filesystem_size_bytes)) * 100 > 90


Triggers when disk usage exceeds **90%**.

### Service Down


up == 0


Triggers when a monitored service becomes unavailable.

## Alert Notification Channels

Configured alert notifications include:

- Email alerts
- Slack webhook notifications
- Grafana alert notifications

## Testing Alerts

To test the alerting system:

1. Generate CPU load
2. Trigger alert rules
3. Verify alerts appear in:
   - Prometheus
   - Alertmanager
   - Grafana
   - Email / Slack notifications

Example CPU stress test:


yes > /dev/null &


Stop the stress test:


killall yes


## Result

After completing this lab:

- Prometheus successfully collects metrics from Node Exporter
- Alert rules detect abnormal system conditions
- Alertmanager routes alerts to notification channels
- Grafana visualizes monitoring data in dashboards
