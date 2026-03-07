This lab focuses on **Kubernetes networking using CNI plugins**.  
The goal was to configure a Kubernetes cluster and implement **Calico**, a widely used Container Network Interface (CNI) plugin that enables pod networking, routing, and network policy enforcement.

After installing Kubernetes and Calico, several test pods were deployed to validate **pod-to-pod connectivity, DNS resolution, and service communication** inside the cluster.

The lab also explored **network policies**, allowing controlled communication between pods for improved cluster security.

---

## Key Skills Practiced

- Understanding Container Network Interface (CNI) architecture
- Installing and configuring **Calico networking**
- Creating and managing Kubernetes pods
- Testing **pod-to-pod networking**
- Service discovery and DNS resolution
- Implementing Kubernetes **Network Policies**
- Basic Kubernetes networking troubleshooting

---

## Technologies Used

- Kubernetes (`kubeadm`, `kubectl`, `kubelet`)
- Docker / container runtime
- Calico CNI
- Linux networking tools
- YAML configuration files

---

## Networking Tests Performed

The following connectivity tests were used to verify the cluster networking:

- Pod-to-pod **ICMP ping**
- Pod-to-pod **HTTP requests**
- **Service DNS resolution**
- **Network policy enforcement**

---

## What I Learned

- How CNI plugins enable networking in Kubernetes
- How Calico assigns pod IPs and manages routing
- How Kubernetes services provide DNS-based service discovery
- How network policies control communication between pods
