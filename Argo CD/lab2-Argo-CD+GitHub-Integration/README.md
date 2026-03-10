This lab demonstrates how to integrate **Argo CD with a GitHub repository** to implement a **GitOps workflow for Kubernetes deployments**.

Argo CD continuously monitors a Git repository and ensures the Kubernetes cluster matches the configuration stored in Git. Any change pushed to the repository is automatically synchronized with the cluster.

---

## Lab Overview

In this lab we:

- Installed Docker and Kubernetes tooling
- Created a local Kubernetes cluster using **Minikube**
- Installed **Argo CD** in the cluster
- Connected Argo CD to a **GitHub repository**
- Deployed a sample **Nginx application**
- Tested **automatic synchronization** when changes were pushed to GitHub
- Observed deployments through the **Argo CD web interface**

---

## Architecture


GitHub Repository
│
│ (Application manifests)
│
▼

Argo CD
│
│ (Monitors repository)
│
▼

Kubernetes Cluster (Minikube)
│
└── Nginx Demo Application


Git becomes the **single source of truth** for the application state.

---

## Tools Used

| Tool | Purpose |
|-----|------|
| Docker | Container runtime |
| kubectl | Kubernetes CLI |
| Minikube | Local Kubernetes cluster |
| Argo CD | GitOps continuous delivery |
| GitHub | Version control and manifest storage |

---

## Application Deployment

A simple Kubernetes deployment was created containing:

- **Deployment** with Nginx containers
- **Service** exposing the application inside the cluster
- **Argo CD Application manifest** referencing the GitHub repository

Argo CD automatically synchronizes the repository state with the cluster.

---

## GitOps Workflow Demonstration

1. Application manifests pushed to GitHub
2. Argo CD detects repository changes
3. Argo CD synchronizes the cluster automatically
4. Kubernetes updates the running deployment

Example change:


replicas: 2 → replicas: 3


After committing this change, Argo CD automatically scaled the deployment.

---

## Useful Commands

Check Argo CD applications:


argocd app list


Get application details:


argocd app get demo-app


Synchronize manually:


argocd app sync demo-app


View deployment status:


kubectl get pods


---

## Accessing the Argo CD Dashboard

The Argo CD web UI can be accessed locally:


https://localhost:8080


Login credentials:


username: admin
password: <retrieved from Kubernetes secret>


From the dashboard you can:

- Monitor application health
- View deployment history
- Trigger manual syncs
- Perform rollbacks

---

## Key Concepts

**GitOps**  
Infrastructure and applications are managed using Git repositories as the source of truth.

**Argo CD**  
A Kubernetes-native continuous delivery tool that deploys applications from Git.

**Declarative Deployment**  
Infrastructure is defined using configuration files rather than manual commands.

---

## Result

By completing this lab:

- Argo CD was installed and configured
- GitHub repository integration was established
- A Kubernetes application was deployed through GitOps
- Automatic synchronization between Git and the cluster was verified
