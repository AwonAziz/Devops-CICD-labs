Build a complete DevOps workflow using **Concourse CI/CD**, **Docker**, **Prometheus**, and **Grafana** to automate testing, building, deployment, and monitoring of a web application.

---

# Lab Steps

### 1. Install Required Tools

Update the system and install tools such as **Docker, Git, curl, and docker-compose**.

Start and enable Docker service.

---

### 2. Create Project Structure

Create the main project folder and subdirectories:

* `concourse/` – Concourse configuration and keys
* `sample-app/` – Flask application
* `monitoring/` – Prometheus and Grafana configuration

---

### 3. Generate Concourse Keys

Generate required SSH keys for:

* host authentication
* worker communication
* session signing

These keys allow **secure communication between Concourse components**.

---

### 4. Deploy Concourse Infrastructure

Create a **docker-compose.yml** file that runs:

* Concourse Web
* Concourse Worker
* PostgreSQL
* Docker Registry
* Prometheus
* Grafana

Start all services using Docker Compose.

---

### 5. Create a Sample Application

Develop a simple **Python Flask application** with:

* `/` endpoint
* `/health` endpoint
* `/metrics` endpoint

Add:

* `requirements.txt`
* `Dockerfile`
* automated tests

Initialize the project using **Git version control**.

---

### 6. Configure Monitoring

Create a **Prometheus configuration** file to monitor:

* Prometheus server
* Concourse
* Sample application

This enables **metrics collection for performance monitoring**.

---

### 7. Install Concourse CLI

Install the **fly CLI** tool which allows interaction with the Concourse server.

Login to the Concourse dashboard using:

* Username: `admin`
* Password: `admin`

---

### 8. Create CI/CD Pipeline

Define a **pipeline.yml** file that contains automated jobs:

1. **Test Code**
   Runs automated tests for the application.

2. **Build Image**
   Builds a Docker image and pushes it to the local registry.

3. **Deploy Application**
   Deploys the containerized application.

4. **Monitoring Check**
   Performs health checks after deployment.

---

### 9. Configure Git Repository

Create a bare Git repository and push the application code.

This repository acts as the **pipeline trigger source**.

---

### 10. Deploy the Pipeline

Use the `fly` CLI to:

* set the pipeline
* unpause the pipeline
* trigger pipeline jobs

This starts the **automated CI/CD workflow**.

---

### 11. Build and Deploy the Application

Build the Docker image and push it to the **local Docker registry**.

Deploy the application using **Docker Compose**.

---

### 12. Verify the Deployment

Test the application endpoints:

* `/`
* `/health`
* `/metrics`

Confirm that the service is running correctly.

---

### 13. Monitoring and Observability

Access monitoring dashboards:

* Concourse UI
* Prometheus
* Grafana

These tools help track **system health and performance metrics**.

---

### 14. Test Pipeline Automation

Make a change in the application code and push it to Git.

The pipeline automatically:

* runs tests
* builds a new image
* redeploys the application

---

# Key Insights

* **CI/CD pipelines automate software delivery.**
* **Containers provide consistent deployment environments.**
* **Monitoring tools help detect system issues early.**
* **Infrastructure as Code simplifies DevOps environments.**
* **Automated testing improves reliability before deployment.**

---

# Takeaways

* Learned how to deploy **Concourse CI/CD pipelines**.
* Implemented **automated testing and container builds**.
* Deployed applications using **Docker containers**.
* Integrated **monitoring using Prometheus and Grafana**.
* Observed the **complete DevOps lifecycle from code commit to production monitoring**.

---

# Conclusion

This lab demonstrated how modern DevOps practices integrate **automation, containerization, CI/CD pipelines, and monitoring** to deliver applications efficiently and reliably.
