This lab focuses on **disaster recovery strategies for Kubernetes clusters** using **Velero**. The goal is to ensure that applications and data running in Kubernetes can be safely backed up and restored in case of failures or data loss.

A Kubernetes cluster was created using **kind**, and **MinIO** was deployed as an S3-compatible storage backend for backups. Velero was then configured to create, manage, and restore backups of cluster resources and persistent data.

The lab also demonstrates how to **automate backup schedules and implement monitoring scripts** to maintain backup health in a production-like environment.

---

## Key Concepts Practiced

- Kubernetes disaster recovery planning
- Cluster resource backups using Velero
- Persistent volume backup and restoration
- Automated backup scheduling with Velero
- Backup validation and monitoring
- Disaster simulation and cluster restoration

---

## Technologies Used

- Kubernetes (kind cluster)
- Velero
- MinIO (S3-compatible object storage)
- Docker
- Helm
- kubectl
- Bash scripting

---

## Backup Workflow

The backup workflow implemented in this lab follows these steps:

1. Deploy a Kubernetes cluster using **kind**
2. Configure **MinIO** as the backup storage backend
3. Install **Velero** in the cluster
4. Deploy a sample application with persistent storage
5. Create backups of namespaces and resources
6. Simulate a disaster by deleting the application namespace
7. Restore the environment using Velero backups

---

## Backup Automation

Velero schedules were configured to automate backups using cron-style scheduling:

- Daily namespace backups
- Weekly full-cluster backups
- Hourly backups for critical workloads
- Custom retention policies for long-term storage

Monitoring and validation scripts were also implemented to ensure that backups are running successfully and that storage usage is controlled.

---

## Testing Disaster Recovery

Several recovery scenarios were tested during the lab:

- Full namespace recovery
- Partial resource restoration
- Persistent volume data verification
- Backup integrity validation
- Rollback testing

These tests confirm that applications and data can be successfully restored after simulated failures.

---

## What I Learned

- How to implement reliable backup systems for Kubernetes
- How Velero manages cluster resource snapshots
- How object storage is used for Kubernetes backups
- How to automate backup policies and retention strategies
- How to validate backups and perform disaster recovery
