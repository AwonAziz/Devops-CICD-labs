This lab focuses on configuring **alerting in Prometheus** to monitor system health and automatically notify administrators when issues occur.

A full monitoring pipeline was built including **Prometheus, Node Exporter, and Alertmanager**. Custom alert rules were created to detect high CPU usage, memory consumption, disk space issues, and service outages. Alertmanager was then configured to send notifications through **email and webhook integrations**.

The lab demonstrates how modern monitoring systems detect problems and trigger automated alerts for faster incident response.

---

## Skills Practiced

- Configuring Prometheus alert rules
- Monitoring system metrics with Node Exporter
- Deploying and configuring Alertmanager
- Creating CPU, memory, disk, and service alerts
- Setting up email notifications using SMTP
- Testing alerts using CPU stress scripts
- Implementing webhook integrations for external notifications

---

## Technologies Used

- Prometheus
- Alertmanager
- Node Exporter
- PromQL
- Linux
- systemd
- Bash scripting
- Python (webhook receiver)

---

## Example Alerts

High CPU usage alert:


100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80


High memory usage alert:


(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100 > 85


Low disk space alert:


(1 - (node_filesystem_avail_bytes / node_filesystem_size_bytes)) * 100 > 90


Service availability check:


up == 0


---

## What I Learned

Through this lab I learned how **Prometheus alerting works end-to-end**:

- Prometheus collects metrics from monitored systems
- Alert rules evaluate metrics using PromQL
- Alerts are sent to Alertmanager
- Alertmanager routes notifications to email or webhooks

This workflow forms the foundation of **production monitoring and incident response systems used in DevOps environments.**
