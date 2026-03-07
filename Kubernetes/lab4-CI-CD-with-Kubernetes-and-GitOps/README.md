This lab demonstrates how to implement a **complete CI/CD pipeline using Jenkins, Kubernetes, and GitOps practices**.

A development environment was built on a single Linux machine where Docker, Kubernetes (Minikube), Jenkins, and ArgoCD were installed. A sample **Node.js application** was containerized using Docker, deployed to Kubernetes, and managed through Git-based workflows.

The pipeline automates application testing, container image building, and Kubernetes deployment. GitOps principles were implemented using **ArgoCD**, ensuring that the cluster state is continuously synchronized with the Git repository configuration.

---

## Key Concepts Practiced

- Continuous Integration and Continuous Deployment (CI/CD)
- Containerized application builds with Docker
- Kubernetes application deployment
- Jenkins pipeline automation
- GitOps workflows using ArgoCD
- Automated deployment and rollback
- Multi-environment deployments (development and production)

---

## Technologies Used

- Docker
- Kubernetes (Minikube)
- Jenkins
- ArgoCD
- Git
- Node.js
- YAML configuration files

---

## CI/CD Workflow

The pipeline implemented in this lab follows these steps:

1. Source code stored in a Git repository
2. Jenkins pipeline builds and tests the application
3. Docker image is built and tagged
4. Kubernetes manifests are updated with the new image version
5. ArgoCD synchronizes the cluster with the Git repository
6. Kubernetes deploys the updated application automatically

---

## GitOps Implementation

GitOps was used to manage Kubernetes deployments declaratively:

- Application manifests stored in a Git repository
- ArgoCD monitors the repository for changes
- Updates are automatically applied to the Kubernetes cluster
- Deployment state remains synchronized with Git

---

## Testing and Validation

Several tests were performed during the lab:

- Building and running the Docker container locally
- Deploying the application to Kubernetes
- Verifying application endpoints
- Simulating version updates
- Testing automated GitOps deployments
- Performing rollback scenarios

---

## What I Learned

- How CI/CD pipelines automate software delivery
- How Jenkins integrates with containerized workflows
- How Kubernetes deployments can be managed using GitOps
- How ArgoCD continuously synchronizes cluster state with Git
- How automated deployments improve reliability and scalability
