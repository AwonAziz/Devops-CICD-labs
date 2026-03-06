This lab demonstrates how to build a complete **CI/CD pipeline for a containerized application** using Docker, GitHub Actions, and Docker Hub.

The pipeline automatically tests application code, builds Docker images, pushes them to a registry, and prepares deployment workflows for staging and production environments.

The project uses a simple **Node.js web service** packaged inside a Docker container to simulate a real deployment workflow.

---

## Key Concepts Practiced

### Continuous Integration
- Automatic testing on every commit
- Node.js dependency installation
- GitHub Actions workflow automation

### Container Image Automation
- Automatic Docker image builds
- Multi-architecture image support
- Image tagging and metadata generation

### Container Registry Integration
- Secure login to Docker Hub
- Automated image push from CI pipeline
- Image version tagging strategy

### Deployment Automation
- Container deployment scripts
- Staging and production environments
- Health checks and restart policies

### Monitoring and Operations
- Container monitoring scripts
- Log inspection and resource tracking
- Rollback procedures for failed deployments

---

## Application

A lightweight **Express.js API** providing:

- `/` – application info endpoint  
- `/health` – health monitoring endpoint

The service runs inside a **Node.js Alpine Docker container**.

---

## Technologies Used

- Docker
- GitHub Actions
- Docker Hub
- Node.js / Express
- Docker Compose
- Bash scripting

---

## CI/CD Pipeline Flow

1. Developer pushes code to GitHub
2. GitHub Actions runs automated tests
3. Docker image is built automatically
4. Image is pushed to Docker Hub
5. Deployment workflow prepares container rollout
6. Monitoring and rollback scripts support operations

---

## Skills Demonstrated

- CI/CD pipeline design
- Docker image automation
- GitHub Actions workflow configuration
- Secure registry authentication
- Container deployment scripting
- Monitoring and rollback strategies
