This lab explores **progressive delivery techniques in Kubernetes using Argo Rollouts**.  
Argo Rollouts extends Kubernetes deployments by providing advanced strategies such as **canary releases** and **blue/green deployments**.

These strategies allow applications to be deployed gradually, minimizing risk and enabling safe rollbacks if issues occur.

---

## Lab Goals

- Install and configure **Argo Rollouts**
- Deploy applications using **canary deployment strategy**
- Implement **blue/green deployment strategy**
- Monitor rollout progress and deployment health
- Perform **rollback and abort operations**
- Understand progressive delivery best practices

---

## Environment

The lab environment consists of:

- **Docker** for container runtime
- **kind (Kubernetes in Docker)** for a local Kubernetes cluster
- **kubectl** for cluster management
- **Argo Rollouts Controller**
- **kubectl Argo Rollouts plugin**

---

## Architecture


Developer Update
│
▼

Kubernetes Rollout Resource
│
▼

Argo Rollouts Controller
│
├── Canary Deployment
│
└── Blue/Green Deployment


Argo Rollouts manages deployment traffic and version transitions in Kubernetes.

---

# Canary Deployment

A **canary deployment** gradually shifts traffic from the stable version to the new version.

Example rollout process:


Version A (stable)
↓
20% traffic → Version B
↓
40% traffic → Version B
↓
60% traffic → Version B
↓
80% traffic → Version B
↓
100% rollout


This staged approach helps detect issues early before full deployment.

---

# Blue/Green Deployment

Blue/Green deployment maintains two environments:

| Environment | Purpose |
|---|---|
| Blue | Current production version |
| Green | New release version |

Deployment flow:

1. Deploy new version to **preview environment**
2. Test the preview service
3. Promote to **active production service**
4. Decommission old version

This approach provides **zero downtime releases**.

---

# Example Kubernetes Rollout

Example of a simple rollout resource:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: rollouts-demo
spec:
  replicas: 5
  strategy:
    canary:
      steps:
        - setWeight: 20
        - pause: {}
        - setWeight: 40
        - pause: {duration: 10}

Argo Rollouts manages the transition between versions automatically.
