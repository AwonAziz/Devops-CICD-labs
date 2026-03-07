This lab focuses on diagnosing and resolving common issues that occur in Kubernetes clusters. A single-node Kubernetes environment was deployed using **kubeadm**, after which several intentionally broken workloads were created in order to practice real-world troubleshooting scenarios.

Different failure types were analyzed including **image pull failures, resource allocation issues, configuration errors, networking problems, and storage issues**.

The goal of this lab was to practice a **systematic debugging workflow using kubectl, kubeadm, logs, and cluster events**.

---

## Key Skills Practiced

- Kubernetes cluster setup using kubeadm
- Diagnosing pod and node issues using `kubectl`
- Analyzing cluster events and logs
- Identifying image pull and configuration failures
- Debugging networking and service issues
- Resolving storage and PVC-related problems
- Monitoring cluster performance using metrics

---

## Tools and Technologies

- Kubernetes
- kubeadm
- kubectl
- Docker / containerd
- Flannel CNI
- Metrics Server
- Bash scripting
- Linux (Ubuntu)

---

## Troubleshooting Scenarios

Several common Kubernetes problems were intentionally deployed and then diagnosed:

### Image Pull Failure
A deployment using a non-existent container image caused pods to enter an `ImagePullBackOff` state.

### Resource Scheduling Failure
Pods requesting excessive CPU and memory remained in the `Pending` state because the node could not satisfy the resource requests.

### Missing Configuration
An application attempted to load a ConfigMap that did not exist.

### Broken Service Networking
A Kubernetes service was created with an incorrect selector, preventing traffic from reaching the intended pods.

### Storage Configuration Failure
A pod attempted to mount a PersistentVolumeClaim that had not been created.

---

## Troubleshooting Techniques Used

Typical diagnostic steps included:

- Inspecting pod states and scheduling
- Analyzing cluster events
- Checking node resource usage
- Reviewing application and system logs
- Verifying service selectors and endpoints
- Testing pod connectivity
- Fixing deployments and configuration resources

---

## Monitoring and Performance Analysis

The **Kubernetes Metrics Server** was installed to monitor cluster resource usage.  

Commands such as:

- `kubectl top nodes`
- `kubectl top pods`

were used to analyze CPU and memory consumption across the cluster.

Custom Bash scripts were also created to automate troubleshooting reports and resource monitoring.

---

## What I Learned

- How to systematically debug Kubernetes clusters
- How to use logs and events to trace application failures
- How Kubernetes scheduling decisions affect workload deployment
- How networking, configuration, and storage issues manifest in cluster behavior
- How monitoring tools help maintain cluster health
