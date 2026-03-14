Configure a Buildkite CI/CD pipeline that builds a Docker application and deploys it to development, staging, and production environments.

Key Steps
1. Install Required Tools

Install the basic tools needed for the pipeline.

Install Docker

Install Docker Compose

Install Git

Install Node.js

Install Buildkite Agent

Verify installations using:

docker --version
docker-compose --version
git --version
node --version
npm --version
2. Create Sample Application

Create a simple Node.js Express application.

Steps:

Create project folder

Initialize Node project (npm init)

Install dependencies (express, dotenv)

Create src/app.js

Add scripts in package.json

This application exposes:

/ → basic application info

/health → health check endpoint

3. Create Environment Configurations

Create environment files:

environments/.env.dev
environments/.env.staging
environments/.env.production

Each file defines variables such as:

NODE_ENV
PORT
APP_VERSION
DATABASE_URL
LOG_LEVEL

This allows the same application to run in multiple environments.

4. Containerize the Application

Create a Dockerfile to build the application image.

Key steps:

Use node:18-alpine

Copy project files

Install dependencies

Expose port 3000

Run application using npm start

Build example:

docker build -t myapp:latest .
5. Create Buildkite Pipeline

Create pipeline file:

.buildkite/pipeline.yml

Pipeline stages:

1️⃣ Build Stage

Build Docker image

Tag image with commit hash

2️⃣ Test Stage

Run application tests

3️⃣ Development Deployment

Runs on develop or feature branches

Deploys container on port 3001

4️⃣ Staging Deployment

Runs on main branch

Deploys container on port 3002

5️⃣ Production Deployment

Requires manual approval

Deploys container on port 3000

6️⃣ Verification Stage

Confirms containers are running

Performs health checks.

6. Deployment Scripts

Deployment logic is handled using scripts inside:

.buildkite/scripts/

Main scripts:

deploy.sh → deploy container to environment

verify.sh → verify deployment health

integration-tests.sh → run API tests

smoke-tests.sh → run basic staging tests

backup.sh → create production backup

monitor.sh → monitor production deployment

Example deployment command:

.buildkite/scripts/deploy.sh dev
7. Initialize Git Repository

Create repository and branches.

Branches used for environments:

develop   → development
feature/* → development
main      → staging + production
8. Test Deployments

Run deployment scripts locally.

Example:

.buildkite/scripts/deploy.sh dev
.buildkite/scripts/deploy.sh staging
.buildkite/scripts/verify.sh

Check application endpoints:

http://localhost:3001
http://localhost:3002
http://localhost:3000
Key Concepts Learned

Buildkite agent installation

Creating CI/CD pipelines

Managing multiple environments

Docker container deployments

Branch-based pipeline triggers

Automated testing and verification
