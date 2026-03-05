This lab explores the fundamentals of Docker images and containers, including how to build, run, inspect, and modify containerized applications.

The focus is on understanding the difference between images and containers, creating custom images using Dockerfiles, and managing container lifecycles effectively.

---

## Objectives

- Understand Docker images vs containers
- Inspect and analyze Docker images
- Build custom images using Dockerfiles
- Run and manage containers
- Use docker commit and docker diff
- Implement multi-stage builds
- Manage container lifecycle and cleanup

---

## Key Exercises

### 1️ Docker Installation
- Installed Docker from official repositories
- Verified installation with `hello-world`
- Configured user permissions

### 2️ Image Inspection & Analysis
- Pulled multiple base images (Ubuntu, Alpine, Nginx, Python)
- Inspected metadata and architecture
- Explored image layers using `docker history`
- Automated inspection with custom bash script

### 3️ Building Custom Images
- Created Python-based web application
- Wrote secure Dockerfile with:
  - Non-root user
  - Health checks
  - Environment variables
- Built and tagged images
- Implemented multi-stage Go build to reduce image size

### 4️ Running & Managing Containers
- Port mapping
- Environment variables
- Volume mounting
- Resource limits (CPU / memory)
- Custom Docker networks
- Monitoring with `docker stats`
- Container inspection and exec access

### 5️ docker commit vs Dockerfile
- Modified running Ubuntu container
- Used `docker diff` to analyze filesystem changes
- Created image using `docker commit`
- Compared reproducibility with Dockerfile-based builds

### 6️ Container Lifecycle Management
- Start / Stop / Restart / Pause containers
- Resource monitoring
- Cleanup using prune commands
- Disk usage inspection

---

## Skills Demonstrated

- Image layer analysis
- Dockerfile best practices
- Multi-stage build optimization
- Container networking
- Resource management
- Change tracking with docker diff
- Image reproducibility comparison
- Container debugging and troubleshooting
