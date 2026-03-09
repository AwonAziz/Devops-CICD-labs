This lab demonstrates how to build a **Kubernetes monitoring stack** using Prometheus for metrics collection and Grafana for visualization.

A local Kubernetes cluster is created using **Minikube**, after which Prometheus is deployed to collect cluster metrics. Grafana is then connected to Prometheus to visualize system health and resource usage through dashboards.

## Objectives

- Deploy a local Kubernetes cluster using Minikube
- Install and configure Prometheus inside Kubernetes
- Deploy Grafana for monitoring dashboards
- Connect Grafana to Prometheus as a data source
- Visualize cluster metrics such as CPU, memory, pod status, and node health
- Create dashboards for Kubernetes observability

## Monitoring Architecture


Kubernetes Cluster
↓
Prometheus (metrics collection)
↓
Grafana (visualization dashboards)


Prometheus gathers metrics from Kubernetes components and workloads, while Grafana provides real-time dashboards for monitoring cluster performance.

## Key Components

**Minikube**
- Runs a local Kubernetes cluster for testing.

**Prometheus**
- Collects and stores time-series metrics from Kubernetes nodes and pods.

**Grafana**
- Visualizes metrics and provides interactive dashboards.

**Metrics Server**
- Provides resource usage metrics inside the cluster.

## Metrics Monitored

Examples of monitored metrics include:

- Node CPU usage
- Node memory utilization
- Disk usage
- Pod CPU consumption
- Pod memory usage
- Pod status
- Cluster resource activity

## Dashboards

### Pre-built Dashboard
Imported Kubernetes dashboard:
- Dashboard ID: **3119**

Displays:

- Cluster resource usage
- Node health
- Pod activity
- Network traffic

### Custom Dashboards

Two custom dashboards were created:

**Pod Monitoring Dashboard**
- Pod CPU usage
- Pod memory usage
- Pod status

**Node Monitoring Dashboard**
- Node CPU utilization
- Node memory usage
- Node disk usage

## Example PromQL Queries

Pod CPU usage:


sum(rate(container_cpu_usage_seconds_total{container!="POD",container!=""}[5m])) by (pod)


Pod memory usage:


sum(container_memory_usage_bytes{container!="POD",container!=""}) by (pod)


Node CPU usage:


100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)


Node memory usage:


(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100


## Testing the Monitoring Stack

A sample application was deployed to generate metrics:


kubectl create deployment nginx-test --image=nginx --replicas=3
kubectl expose deployment nginx-test --port=80 --type=NodePort


After deployment, the new pods and resource usage become visible in Grafana dashboards.

## Result

After completing the lab:

- A working **Kubernetes cluster** was deployed locally
- **Prometheus collected cluster metrics**
- **Grafana visualized metrics through dashboards**
- Kubernetes workloads could be monitored in real time
