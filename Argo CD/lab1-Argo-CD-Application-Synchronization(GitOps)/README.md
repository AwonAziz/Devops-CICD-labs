This lab demonstrates how to manage Kubernetes applications using **Argo CD and GitOps synchronization workflows**.

Argo CD continuously monitors a Git repository and ensures that the Kubernetes cluster state matches the configuration stored in Git.

The lab explores both **automatic synchronization (auto-sync)** and **manual synchronization**, showing how Git changes propagate to Kubernetes deployments.

---

## Lab Goals

- Install a local Kubernetes cluster using **Kind**
- Install and configure **Argo CD**
- Create GitOps repositories for Kubernetes applications
- Deploy applications through Argo CD
- Configure **automatic synchronization**
- Perform **manual synchronization**
- Test **self-healing and pruning behavior**

---

# GitOps Workflow


Developer commits change → Git repository updates
↓
Argo CD detects change
↓
Application sync triggered
↓
Kubernetes cluster updated


Git becomes the **single source of truth** for cluster configuration.

---

# Technologies Used

| Tool | Purpose |
|----|----|
| Kubernetes (Kind) | Local Kubernetes cluster |
| Docker | Container runtime |
| Argo CD | GitOps continuous delivery |
| kubectl | Kubernetes CLI |
| Git | Version control for manifests |

---

# Environment Architecture


Git Repository
│
├── apps
│ ├── nginx-app
│ ├── apache-app
│ └── redis-app
│
Argo CD
│
└── Kubernetes Cluster (Kind)


Argo CD reads Kubernetes manifests from Git and applies them to the cluster.

---

# Applications Deployed

### Nginx Application
- Deployment with **auto-sync enabled**
- Automatically updates when Git changes

### Apache Application
- Deployment with **manual synchronization**
- Requires explicit sync command

### Redis Application
- Deployment with advanced sync policies
- Includes retry logic and pruning

---

# Argo CD Synchronization Types

## Automatic Sync

Automatically applies changes from Git to the cluster.

Features:

- **Self Healing**
- **Pruning**
- Continuous reconciliation

Example configuration:

yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
Manual Sync

Changes in Git do not deploy automatically.

Requires a manual command:

argocd app sync <application-name>

This approach is common in production environments where deployments require approval.

Example GitOps Repository Structure
gitops-demo/
│
├── apps/
│   ├── nginx-app/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   │
│   ├── apache-app/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   │
│   └── redis-app/
│       └── deployment.yaml
Key Argo CD Commands

List applications:

argocd app list

View application status:

argocd app get nginx-app

Manually synchronize application:

argocd app sync apache-app

View application history:

argocd app history nginx-app

Rollback deployment:

argocd app rollback nginx-app <revision>
Testing Synchronization
Auto Sync Test

Modify application manifest

Commit change to Git

Argo CD automatically updates deployment

Example:

git commit -m "Update nginx version"

Argo CD detects the change and updates pods automatically.

Manual Sync Test

Modify manifest

Commit change

Application becomes OutOfSync

Run manual sync

argocd app sync apache-app
Self Healing Demonstration

If a Kubernetes resource is changed manually:

kubectl scale deployment nginx-deployment --replicas=5

Argo CD automatically reverts it back to the Git defined state.

This ensures cluster consistency.

Pruning Demonstration

When resources are removed from Git:

git commit -m "Remove configmap"

Argo CD automatically deletes the resource from the cluster.

Verification

Check application state:

argocd app list

Verify running pods:

kubectl get pods

Test services:

kubectl port-forward svc/nginx-service 8081:80
Cleanup

Delete applications:

argocd app delete nginx-app --cascade

Remove cluster:

kind delete cluster --name argocd-lab
