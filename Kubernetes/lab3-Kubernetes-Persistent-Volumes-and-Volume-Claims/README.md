This lab explores **persistent storage in Kubernetes** using **PersistentVolumes (PV)** and **PersistentVolumeClaims (PVC)**.

A Kubernetes cluster was deployed on a single Linux machine. Local storage was configured as a PersistentVolume, and applications accessed this storage using a PersistentVolumeClaim. Pods were then deployed using the claim to verify that **data persists even after pod restarts or deletion**.

The lab also demonstrated **data sharing between multiple pods**, monitoring storage usage, and basic troubleshooting of Kubernetes storage resources.

---

## Key Concepts Practiced

- Kubernetes **PersistentVolumes (PV)**
- Kubernetes **PersistentVolumeClaims (PVC)**
- Local storage using **hostPath volumes**
- Mounting persistent storage into containers
- Data persistence across pod lifecycle events
- Multi-pod data access
- Monitoring and testing Kubernetes storage

---

## Technologies Used

- Kubernetes (`kubeadm`, `kubectl`, `kubelet`)
- Docker container runtime
- Flannel CNI networking
- YAML configuration files
- Linux filesystem storage

---

## Storage Workflow

1. Create a host storage directory (`/mnt/data`)
2. Define a **PersistentVolume (PV)** referencing the host storage
3. Create a **PersistentVolumeClaim (PVC)** requesting storage
4. Deploy a pod that mounts the PVC
5. Write and read data from inside the container
6. Delete and recreate the pod to verify **data persistence**
7. Attach a second pod to confirm **shared storage access**

---

## Persistence Testing

The following tests were performed:

- Writing files from a container to the mounted volume
- Verifying data exists on the host system
- Restarting pods and confirming files remain
- Accessing the same data from multiple pods
- Monitoring storage usage and file creation

---

## What I Learned

- How Kubernetes separates **storage provisioning (PV)** from **storage consumption (PVC)**
- How applications mount persistent storage
- How Kubernetes handles storage across pod lifecycle events
- How persistent storage supports **stateful workloads**
- Basic troubleshooting for Kubernetes storage issues
