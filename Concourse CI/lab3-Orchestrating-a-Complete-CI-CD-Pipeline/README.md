Set up a complete CI/CD pipeline using Concourse CI on a single Linux machine.  
The pipeline will build, test, and deploy a Node.js application using Docker containers and Git.

## Tools Used
- Linux (Ubuntu)
- Docker
- Docker Compose
- Concourse CI
- Fly CLI
- Git
- Node.js
- Express.js
- Jest

---

# Task 1 – Environment Setup

Update the system and install required packages.  
Install Docker, Docker Compose, and Fly CLI which will be used to interact with Concourse CI.

---

# Task 2 – Setup Concourse CI

Create a Docker Compose configuration for Concourse including:
- PostgreSQL database
- Concourse web service
- Concourse worker

Generate required SSH keys and start the services.

Login to Concourse using the Fly CLI.

Web Interface:

http://localhost:8080


Credentials:

username: admin
password: admin


---

# Task 3 – Create Sample Application

Create a simple Node.js application using Express.

Endpoints:

GET / -> Welcome message
GET /health -> Health check


Create:
- `app.js`
- `package.json`
- `app.test.js`
- `Dockerfile`
- `deploy.sh`

Commit the application to a local Git repository.

---

# Task 4 – Create CI/CD Pipeline

Create a Concourse pipeline configuration.

Pipeline stages:

1. **Build**
   - Install dependencies

2. **Test**
   - Run Jest tests

3. **Deploy**
   - Build Docker image
   - Run container
   - Verify deployment

Deploy the pipeline using Fly CLI.

---

# Task 5 – Trigger and Monitor Pipeline

Manually trigger the pipeline and watch execution logs.

You can monitor the pipeline using:

- Fly CLI
- Concourse Web UI

The pipeline will automatically build, test, and deploy the application.

---

# Task 6 – Verify Deployment

Check running containers and test the deployed application.

Test endpoints:


http://localhost:3001

http://localhost:3002

http://localhost:3003/health


---

# Task 7 – Advanced Pipeline

Create a final pipeline with:

- preparation stage
- testing
- docker build
- deployment
- post-deployment verification
- failure notification

---

# Verification

Check services:


docker-compose ps
fly -t tutorial pipelines
docker ps


Test application:


curl http://localhost:3003/health


---

# Conclusion

In this lab we:

- Installed Docker and Concourse CI
- Created a Node.js sample application
- Built a complete CI/CD pipeline
- Automated build, test, and deployment
- Monitored pipelines using Fly CLI and Web UI
