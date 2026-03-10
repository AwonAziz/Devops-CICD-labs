This lab demonstrates how Docker can be integrated with Jenkins to automate container builds and deployments within a CI/CD pipeline.

## Overview

A Linux environment was prepared by installing Docker, Java, and Jenkins.  
Jenkins was then configured to work with Docker so pipelines could build container images, test them, and push them to a container registry.

A sample Node.js application was created and containerized using a Dockerfile. Jenkins pipelines were used to automate the build and deployment process.

## Docker and Jenkins Integration

Docker was installed and configured so the Jenkins user could execute Docker commands.  
The **Docker Pipeline plugin** was added to Jenkins to enable container operations directly from pipeline scripts.

This integration allows Jenkins pipelines to:

- Build Docker images from application source code
- Run containers for testing
- Push images to Docker Hub
- Deploy containers automatically

## Sample Application

A small Node.js application using Express was created to demonstrate the workflow.  
The application exposes two endpoints:

- `/` – returns application information
- `/health` – provides a simple health check

The application was containerized using a **Dockerfile** that installs dependencies and runs the Node.js server.

## Jenkins Pipeline Workflow

A Jenkins pipeline was created to automate the entire container lifecycle.

Pipeline stages included:

1. **Checkout** – Copy project files into the Jenkins workspace  
2. **Build Image** – Build Docker images using the project Dockerfile  
3. **Test Image** – Run the container and verify application endpoints  
4. **Docker Hub Login** – Authenticate with Docker Hub using stored credentials  
5. **Push Image** – Upload the built image to Docker Hub  
6. **Deploy Container** – Run the container locally to simulate deployment  

## Multi-Stage Docker Builds

An additional pipeline demonstrated multi-stage Docker builds to produce optimized production images.

This approach:

- separates build and runtime environments
- reduces final image size
- improves container security

## Key Concepts Learned

- Installing and configuring Docker on Linux
- Setting up Jenkins with Docker integration
- Building Docker images in CI/CD pipelines
- Running automated container tests
- Pushing images to Docker Hub
- Deploying containers automatically through Jenkins
