This lab demonstrates how to manage application secrets securely in a GitOps workflow using **Argo CD**, **Kubernetes Secrets**, **HashiCorp Vault**, and the **External Secrets Operator**.

## Objectives

- Understand secure secrets management in GitOps
- Use Kubernetes Secrets with applications
- Configure HashiCorp Vault for external secrets
- Sync secrets automatically using External Secrets Operator
- Integrate Vault secrets with Kubernetes workloads
- Apply security best practices for secret management

## Technologies Used

- Kubernetes (kind cluster)
- Argo CD
- HashiCorp Vault
- External Secrets Operator
- Git (GitOps workflow)
- Docker

## Lab Overview

### 1. Environment Setup
- Install Docker and essential tools
- Install Kubernetes CLI tools
- Create a local Kubernetes cluster using **kind**

### 2. Argo CD Installation
- Deploy Argo CD in the cluster
- Access the Argo CD UI
- Retrieve the admin password

### 3. Kubernetes Secret Management
- Create secrets manually in Kubernetes
- Deploy an application that consumes those secrets
- Configure GitOps repository structure

### 4. GitOps with Argo CD
- Create a Git repository for application manifests
- Configure an Argo CD Application
- Sync the application with the cluster

### 5. HashiCorp Vault Integration
- Install and configure Vault
- Store secrets inside Vault
- Enable Kubernetes authentication

### 6. External Secrets Operator
- Install External Secrets Operator
- Create SecretStore connected to Vault
- Sync Vault secrets into Kubernetes automatically

### 7. Vault-Managed Application
- Deploy an application using Vault-synced secrets
- Mount secrets as environment variables and volumes

### 8. Verification & Testing
- Verify secret synchronization
- Test secret rotation
- Confirm applications consume updated secrets

### 9. Security Best Practices
- Apply Vault policies
- Configure RBAC
- Monitor secret changes

## Key Learning Outcomes

After completing this lab you should be able to:

- Manage secrets securely in GitOps environments
- Integrate Vault with Kubernetes
- Use External Secrets Operator for secret synchronization
- Apply security best practices in CI/CD pipelines
