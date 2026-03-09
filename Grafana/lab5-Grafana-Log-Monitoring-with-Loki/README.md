This lab demonstrates how to build a **log monitoring and visualization stack** using Grafana, Loki, and Promtail.

Loki acts as a centralized log aggregation system, while Promtail collects logs from the Linux system and sends them to Loki. Grafana is then used to visualize and query these logs through dashboards.

## Objectives

- Install and configure Loki for centralized log storage
- Install Promtail to collect logs from Linux system services
- Deploy Grafana for log visualization
- Connect Loki as a data source in Grafana
- Build dashboards for log monitoring and analysis
- Create queries and filters to analyze log data

## Logging Architecture


System Logs
↓
Promtail (log shipper)
↓
Loki (log storage + indexing)
↓
Grafana (log visualization)


Promtail collects logs from the system and forwards them to Loki. Grafana then queries Loki to display logs through dashboards.

## Key Components

**Loki**
- Log aggregation system designed for efficiency and scalability
- Stores logs without heavy indexing

**Promtail**
- Log collection agent
- Sends logs to Loki

**Grafana**
- Visualization platform for metrics and logs
- Provides dashboards and log querying interface

## Log Sources Collected

Promtail collects logs from:

- `/var/log/syslog`
- `/var/log/auth.log`
- `/var/log/*.log`
- `/var/log/nginx/*.log`
- Sample application logs

## Sample Log Generator

A script was created to generate application logs for testing:


/var/log/sample_app.log


These logs simulate events such as:

- INFO messages
- WARNING events
- ERROR logs
- DEBUG output

This helps demonstrate real-time log ingestion and visualization.

## Example Loki Queries

View all logs from sample application:


{job="sample_app"}


Filter only error logs:


{job="sample_app"} |= "ERROR"


Count logs over time:


count_over_time({job="sample_app"}[5m])


Log rate:


rate({job="sample_app"}[5m])


## Dashboard Panels

The Grafana dashboard includes panels such as:

**Sample Application Logs**
- Displays real-time application logs

**System Logs**
- Displays logs from Linux system services

**Authentication Logs**
- Shows login and authentication events

**Log Level Distribution**
- Visualizes the number of logs by severity level

## Log Alerts

An alert rule can be created to detect excessive error logs:

Example alert condition:


count_over_time({job="sample_app"} |= "ERROR" [5m]) > 5


This helps identify abnormal system behavior quickly.

## Result

After completing the lab:

- Loki successfully stores centralized logs
- Promtail continuously collects system logs
- Grafana visualizes logs in dashboards
- Log queries enable filtering and analysis
- Alerts can detect abnormal log patterns
