This lab demonstrates how **Helm can be integrated with CI/CD pipelines** to automate Kubernetes deployments.  
You will configure **Jenkins**, create a **Helm-based deployment pipeline**, and implement a basic **GitOps workflow**.

## Objectives

- Install and configure Jenkins for CI/CD automation
- Integrate Helm with Jenkins pipelines
- Build and deploy containerized applications to Kubernetes
- Implement automated deployment workflows
- Add testing and validation stages to CI/CD pipelines
- Understand best practices for Helm in production environments

## Technologies Used

- Docker
- Kubernetes (Kind)
- Helm
- Jenkins
- Git
- Kubectl
- Linux CLI

## Lab Overview

### Environment Setup

The environment is prepared by installing required tools including:

- Docker for containerization
- Kind for running a Kubernetes cluster in Docker
- kubectl for interacting with Kubernetes
- Helm for application deployment

A local Kubernetes cluster is created using **Kind**.

### Jenkins CI/CD Setup

Jenkins is installed and configured to automate build and deployment tasks.  
Required plugins are installed to support **Docker, Kubernetes, Git, and pipeline automation**.

### Application and Helm Chart

A simple **Node.js application** is created and containerized using Docker.  
A Helm chart is then generated to define the Kubernetes resources required for deployment.

### Git and Pipeline Integration

The project is stored in a Git repository and a **Jenkinsfile pipeline** is created.  
The pipeline performs several automated stages such as:

- Source code checkout
- Docker image build
- Helm chart linting and validation
- Kubernetes deployment

### Automated Testing and Deployment

The pipeline includes stages for testing, staging deployments, and production releases.  
Helm commands are used to deploy and manage application versions within the cluster.

## Key Concepts Learned

- CI/CD pipelines with Jenkins
- Helm-based Kubernetes deployments
- GitOps workflow fundamentals
- Automated testing in CI/CD
- Helm chart validation and deployment automation
