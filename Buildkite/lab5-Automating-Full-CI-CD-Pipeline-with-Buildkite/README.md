## Objective

Create a **complete CI/CD pipeline** using Buildkite to automatically:

* Build the application
* Run tests
* Perform quality/security checks
* Deploy to staging and production
* Monitor deployments

---

# 1. Install Dependencies

Update system and install required tools.

* Git
* Python
* Node.js
* Docker
* Buildkite Agent
* Testing tools (pytest, flake8, bandit, jest)

---

# 2. Create Project Structure

Create project directory and initialize Git.

Main folders:

* `src/backend`
* `src/frontend`
* `tests/unit`
* `tests/integration`
* `tests/e2e`
* `.buildkite`

---

# 3. Create Sample Application

Backend:

* Python Flask API
* Health endpoint
* Users API
* Metrics endpoint

Frontend:

* HTML dashboard
* JavaScript API calls
* Simple UI for users and metrics.

---

# 4. Create Test Suite

Add automated tests:

**Unit tests**

* Test API endpoints
* Validate responses

**Integration tests**

* Start backend server
* Test full API workflow

**E2E tests**

* Test frontend interaction using Selenium

---

# 5. Configure Buildkite Pipeline

Create pipeline file:

```
.buildkite/pipeline.yml
```

Pipeline stages:

1. Setup environment
2. Code quality checks
3. Security scanning
4. Run unit tests
5. Build Docker image
6. Run integration tests
7. Deploy to staging
8. Run staging tests
9. Deploy to production
10. Post-deployment monitoring

Optional:

* Manual **rollback stage** for production.

---

# 6. Build Docker Image

Create application image using:

```
deployment/Dockerfile
```

Image contains:

* Python backend
* Application dependencies
* Runtime configuration.

---

# 7. Run the CI/CD Pipeline

Buildkite Agent executes the pipeline automatically when code is pushed.

Pipeline flow:

```
Commit → Build → Test → Scan → Deploy → Monitor
```

---

# Key Insights

* CI/CD pipelines automate the **software delivery lifecycle**.
* Buildkite manages **pipeline execution and stages**.
* Automated tests ensure **code quality and stability**.
* Docker enables **consistent deployment environments**.
* Monitoring verifies **successful production deployment**.

---

# Takeaways

* Built a **complete DevOps CI/CD workflow**
* Implemented **automated testing and security checks**
* Deployed applications using **Docker containers**
* Automated **staging and production deployments**
* Implemented **monitoring and rollback capability**
