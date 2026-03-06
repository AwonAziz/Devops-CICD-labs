This lab explores the **core architecture of a Kubernetes cluster** and the roles played by its control plane and worker node components.

A Kubernetes cluster was installed from scratch using `kubeadm`, and key services such as **kube-apiserver, etcd, kubelet, kube-controller-manager, and kube-scheduler** were inspected to understand how they interact to manage containerized workloads.

The lab also covered **service management using systemctl**, log analysis, and basic troubleshooting of Kubernetes components.

---

## Key Concepts Practiced

- Kubernetes control plane architecture
- Worker node components and responsibilities
- Installing Kubernetes using `kubeadm`
- Container runtime configuration (containerd)
- Managing services with `systemctl`
- Inspecting Kubernetes system pods
- Viewing component logs and diagnostics
- Understanding communication between cluster components

---

## Kubernetes Components Observed

### Control Plane

- **kube-apiserver** – exposes the Kubernetes API and acts as the cluster entry point  
- **etcd** – distributed key-value store holding cluster state  
- **kube-controller-manager** – runs controllers that maintain cluster state  
- **kube-scheduler** – assigns pods to nodes based on resources and policies  

### Worker Node

- **kubelet** – node agent communicating with the control plane  
- **kube-proxy** – manages networking and service routing  
- **containerd** – container runtime responsible for running containers  

---

## Tools Used

- Kubernetes (`kubeadm`, `kubectl`, `kubelet`)
- containerd
- systemctl
- journalctl
- Linux CLI utilities

---

## What I Learned

- How Kubernetes control plane services operate
- How worker nodes communicate with the control plane
- How to inspect cluster components and logs
- How to start, stop, and manage Kubernetes services
- Basic Kubernetes troubleshooting techniques
