## Objective

Set up a Kubernetes environment using Minikube and automate application deployments using Concourse CI/CD pipelines.

## Tools Used

* Linux (Ubuntu)
* Docker
* Kubernetes
* kubectl
* Minikube
* Concourse CI
* Fly CLI
* Docker Compose

---

# Task 1 – Environment Setup

Update the system and install required dependencies.

Install:

* Docker
* kubectl
* Minikube

Start a **local Kubernetes cluster** using Minikube and verify the cluster connection.

---

# Task 2 – Install and Configure Concourse CI

Install Docker Compose and configure Concourse services.

Components deployed:

* PostgreSQL database
* Concourse Web
* Concourse Worker

Access the web interface:

http://localhost:8080

Credentials:

username: admin
password: admin

Use **Fly CLI** to interact with Concourse pipelines.

---

# Task 3 – Create Kubernetes Application

Create a simple **Nginx web application**.

Files created:

* `index.html`
* `Dockerfile`
* `deployment.yaml`
* `service.yaml`

The application will run with:

* **2 replicas**
* **NodePort service**
* Exposed on port **30080**

Build the Docker image and load it into Minikube.

---

# Task 4 – Create Concourse Pipeline

Create a Concourse pipeline that:

1. Pulls application source code
2. Deploys Kubernetes manifests
3. Waits for deployment rollout
4. Displays deployment status

Deploy the pipeline using **Fly CLI**.

---

# Task 5 – Monitor Kubernetes Deployment

Create monitoring scripts to check:

* Cluster status
* Node status
* Pods
* Services
* Logs
* Deployment events

Create a health check script to verify the application.

Application URL:

http://<minikube-ip>:30080

---

# Task 6 – Testing and Validation

Test the pipeline by:

1. Updating the application
2. Rebuilding the Docker image
3. Reloading the image into Minikube
4. Triggering the pipeline again

Verify rollout status and application accessibility.

---

# Verification

Check Kubernetes resources:

kubectl get nodes
kubectl get deployments
kubectl get pods
kubectl get services

Test application:

curl http://$(minikube ip):30080

Check pipelines:

fly -t tutorial pipelines

---

# Conclusion

In this lab we:

* Installed Kubernetes using Minikube
* Deployed Concourse CI
* Built a Dockerized web application
* Created automated deployment pipelines
* Deployed the application to Kubernetes
* Monitored deployment and application health

This demonstrates how CI/CD pipelines can automate Kubernetes application deployments.
