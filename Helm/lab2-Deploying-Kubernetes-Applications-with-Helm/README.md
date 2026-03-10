This lab demonstrates how to deploy and manage applications in Kubernetes using **Helm**, the Kubernetes package manager. Helm simplifies application deployment by using **pre-configured charts** that define Kubernetes resources.

## Objectives

- Install and configure Helm on a Kubernetes cluster
- Deploy applications using Helm charts from public repositories
- Customize deployments using `values.yaml`
- Manage Helm releases (install, upgrade, rollback, uninstall)
- Explore Helm chart structure and configuration
- Troubleshoot common deployment issues

## Technologies Used

- Docker
- Kubernetes (Minikube)
- Helm
- Kubectl
- Linux CLI

## Lab Overview

### Environment Setup

The environment is prepared by installing:

- Docker (container runtime)
- kubectl (Kubernetes CLI)
- Minikube (local Kubernetes cluster)
- Helm (Kubernetes package manager)

Minikube is used to run a **single-node Kubernetes cluster locally**.

### Deploying Applications with Helm

Helm repositories contain ready-to-use Kubernetes applications.  
In this lab you deploy **NGINX** using the Bitnami Helm chart and verify the deployment using `kubectl` and Helm commands.

### Customizing Deployments

Helm allows configuration changes through **values.yaml** files.  
You create custom configuration files to modify:

- number of replicas
- container image version
- service type
- resource limits
- custom HTML content

A new Helm release is then deployed using these custom values.

### Upgrading and Rolling Back

Helm supports application lifecycle management.  
In this lab you:

- upgrade a running release
- view release history
- rollback to a previous version if needed

### Deploying a Complex Application

To demonstrate Helm with multi-component applications, you deploy **WordPress with MySQL** using a Helm chart and custom configuration.

### Key Concepts Learned

- Helm Charts
- Helm Repositories
- Helm Releases
- values.yaml configuration
- Kubernetes resource templating

## Learning Outcome

After completing this lab you should be able to deploy, configure, upgrade, and manage Kubernetes applications using Helm in a DevOps workflow.
