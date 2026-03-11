In this lab, we explore **job dependencies in CI/CD pipelines** using **GitLab CI/CD**.

Modern CI/CD pipelines often consist of multiple jobs that must execute in a **specific order**. Some jobs cannot start until others have completed successfully. GitLab allows this behavior using the **`needs` keyword**, which explicitly defines job dependencies.

You will create a pipeline where:

- The **build job runs first**
- **Test jobs depend on the build job**
- A **security scan depends on the tests**
- **Deployment depends on the security scan**

This creates a **multi-stage pipeline with clear dependency management**.

---

# Lab Objectives

By completing this lab you will be able to:

- Understand **job dependencies** in CI/CD pipelines
- Create **sequential pipeline workflows**
- Use the **`needs` clause** in GitLab CI
- Implement **multi-stage CI/CD pipelines**
- Ensure **correct execution order of jobs**
- Verify and troubleshoot **dependency issues**

---

# Prerequisites

Before starting this lab, you should have:

- Basic Linux command line knowledge
- Familiarity with **YAML syntax**
- Basic understanding of **Git**
- Basic knowledge of **CI/CD pipelines**

---

# Lab Environment

The lab environment is a **Linux machine provided by Al Nafi**.

Required tools:

- Git
- Docker
- GitLab Runner
- Python3
- curl / wget
- nano or vim# Task 1 – Environment Setup

First update the system and install required tools.


sudo apt update
sudo apt install -y git docker.io curl wget nano vim python3 python3-pip


Start Docker:


sudo systemctl start docker
sudo systemctl enable docker


Add the current user to the Docker group:


sudo usermod -aG docker $USER


Install GitLab Runner:


curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh
 | sudo bash
sudo apt install -y gitlab-runner


Verify installation:


gitlab-runner --version


---

# Task 2 – Create Project Structure

Create the project directory:


mkdir -p ~/pipeline-dependencies-lab
cd ~/pipeline-dependencies-lab


Create subdirectories:


mkdir -p src tests scripts


Initialize Git repository:


git init


---

# Task 3 – Create Sample Application

Create a simple **Python calculator application**.

Location:


src/app.py


This application provides basic functions:

- Addition
- Subtraction
- Multiplication
- Division

---

# Task 4 – Create Build and Deployment Scripts

Three scripts will simulate a CI/CD pipeline:

### Build Script


scripts/build.sh


Simulates compiling the application and creating artifacts.

---

### Security Scan Script


scripts/security_scan.sh


Simulates a vulnerability scan.

---

### Deployment Script


scripts/deploy.sh


Simulates deployment to an environment.

---

# Task 5 – Define CI/CD Pipeline

Create the GitLab pipeline configuration file:


.gitlab-ci.yml


Pipeline stages:


build
test
security
deploy


Example dependency configuration:

```yaml
unit_tests:
  stage: test
  needs: ["build_application"]

This ensures that unit tests only run after the build job completes.

Pipeline Dependency Flow
build_application
      ↓
unit_tests
integration_tests
      ↓
security_scan
      ↓
deploy_staging
      ↓
deploy_production
Task 6 – Simulating Pipeline Execution

Run a simple pipeline simulation:

./simulate_pipeline.sh

Run dependency-aware simulation:

./simulate_dependencies.sh

This demonstrates how jobs execute only after their dependencies complete.

Task 7 – Pipeline Validation

Validate pipeline configuration:

./validate_pipeline.sh

The validation script checks:

YAML syntax

Dependency structure

Pipeline execution simulation

Expected Output

Example pipeline execution order:

build_application
unit_tests
integration_tests
security_scan
deploy_staging
deploy_production

Each job runs only after its dependencies are satisfied.

Troubleshooting
YAML Syntax Errors

Validate YAML manually:

python3 -c "import yaml,sys;yaml.safe_load(open('.gitlab-ci.yml'))"
Script Permission Issues

Make scripts executable:

chmod +x scripts/*.sh
Missing Build Artifacts

Ensure the build job creates the required files in the build/ directory.

Key Learning Outcomes

After completing this lab you should understand:

CI/CD job dependency management

The purpose of GitLab needs

Sequential vs parallel job execution

CI/CD pipeline design principles
