## Objective

Integrate **Prometheus**, **Grafana**, and **Alertmanager** to monitor Buildkite pipeline performance and generate alerts.

---

# 1. Install Dependencies

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl git docker.io docker-compose jq

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

Re-login to apply Docker permissions.

---

# 2. Create Project Structure

```bash
mkdir -p ~/buildkite-monitoring/{prometheus,grafana,alertmanager,buildkite-exporter}
cd ~/buildkite-monitoring
```

---

# 3. Configure Prometheus

Create configuration files:

* `prometheus/prometheus.yml`
* `prometheus/buildkite_rules.yml`

Prometheus will:

* Scrape metrics from the **Buildkite exporter**
* Evaluate alert rules
* Send alerts to **Alertmanager**

---

# 4. Configure Grafana

Create provisioning directories:

```bash
mkdir -p grafana/provisioning/{datasources,dashboards}
```

Add:

* Prometheus **datasource configuration**
* Dashboard provisioning
* Buildkite **dashboard JSON**

---

# 5. Configure Alertmanager

Create configuration:

```
alertmanager/alertmanager.yml
```

Alertmanager handles:

* Pipeline failure alerts
* Long running builds
* Exporter downtime
* High queued builds

Alerts are forwarded using **webhooks**.

---

# 6. Create Buildkite Metrics Exporter

Inside `buildkite-exporter/` create:

* `exporter.py`
* `requirements.txt`
* `Dockerfile`

The exporter:

* Collects pipeline metrics
* Exposes metrics on **port 8080**
* Sends data to Prometheus

---

# 7. Create Webhook Receiver

Create:

* `webhook_receiver.py`
* `webhook_requirements.txt`
* `webhook.Dockerfile`

The webhook service:

* Receives **Buildkite events**
* Records build durations
* Handles alerts from Alertmanager
* Exposes metrics on **port 8081**

---

# 8. Create Docker Compose Stack

Create `docker-compose.yml` to run:

* Prometheus
* Grafana
* Alertmanager
* Buildkite Exporter
* Webhook Receiver

---

# 9. Start Monitoring Stack

```bash
docker compose up -d --build
```

Check containers:

```bash
docker ps
```

---

# 10. Access Monitoring Tools

| Tool             | URL                           |
| ---------------- | ----------------------------- |
| Prometheus       | http://localhost:9090         |
| Grafana          | http://localhost:3000         |
| Alertmanager     | http://localhost:9093         |
| Exporter Metrics | http://localhost:8080/metrics |

Grafana login:

```
username: admin
password: admin123
```

---

# Key Insights

* **Prometheus** collects Buildkite metrics.
* **Grafana** visualizes pipeline performance.
* **Alertmanager** triggers alerts for failures or slow builds.
* **Webhook receiver** processes real-time pipeline events.

---

# Takeaways

* Implemented monitoring for CI/CD pipelines.
* Built dashboards to analyze pipeline performance.
* Configured automated alerts for failures.
* Integrated Buildkite metrics with Prometheus ecosystem.
