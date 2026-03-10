This lab introduces the **core architecture of Helm**, the Kubernetes package manager.  
You will explore **Helm Charts, Repositories, and the Helm CLI**, and understand how these components work together to manage Kubernetes applications.

## Objectives

- Understand Helm architecture and components
- Explore the structure of Helm Charts
- Work with Helm repositories
- Use Helm CLI commands to manage deployments
- Manage chart dependencies
- Customize charts using values files

## Technologies Used

- Kubernetes (Minikube)
- Helm
- Docker
- Kubectl
- Linux CLI

## Lab Overview

### 1. Environment Setup
Install required tools:

- Docker
- kubectl
- Minikube
- Helm

Then start a local Kubernetes cluster using **Minikube**.

### 2. Helm Charts

Learn how Helm charts are structured and explore key files:

- `Chart.yaml` – metadata about the chart  
- `values.yaml` – default configuration values  
- `templates/` – Kubernetes resource templates  
- `charts/` – chart dependencies  

Create and render charts using Helm templates.

### 3. Helm Repositories

Work with Helm repositories to manage and distribute charts:

- Add public repositories
- Search for charts
- Download charts
- Create a local Helm repository

### 4. Helm CLI Operations

Use the Helm CLI to:

- Install applications
- List releases
- Upgrade deployments
- Rollback versions
- Test and uninstall releases

### 5. Complete Workflow

Create a full-stack Helm chart with dependencies such as:

- MySQL
- Redis

Deploy the chart using custom configuration values.

## Key Learning Outcomes

After completing this lab you will be able to:

- Understand Helm architecture
- Create and customize Helm charts
- Work with Helm repositories
- Deploy applications using Helm CLI
- Manage Helm releases and dependencies
