This lab focuses on writing efficient, secure, and production-ready Dockerfiles.

The objective is to understand how Docker image layers work, how to optimize builds using multi-stage techniques, and how to apply security and performance best practices when containerizing applications.

---

## Core Concepts Covered

- Dockerfile structure and layering
- Multi-stage builds
- Image size optimization
- Layer caching strategies
- Build arguments and environment variables
- Health checks
- Non-root user security
- Build context optimization with .dockerignore
- Security hardening techniques

---

## Implementations

### 1️ Basic Dockerfile (Node.js)
- Built a simple web application
- Created a standard Dockerfile
- Built and tested container
- Analyzed image size

### 2️ Multi-Stage Build (TypeScript App)
- Created inefficient single-stage image
- Implemented optimized multi-stage Dockerfile
- Compared image sizes
- Verified runtime behavior and health checks

### 3️ Production Optimization (Flask App)
- Used minimal base images
- Installed dependencies efficiently
- Implemented non-root user
- Added health checks
- Reduced attack surface

### 4️ Advanced Techniques
- Build arguments (ARG)
- Environment configuration
- Conditional package installation
- Image layer inspection
- Startup performance testing

### 5️ Build Cache Demonstration
- Optimized Dockerfile order for caching
- Compared first vs cached builds
- Demonstrated reduced build time

### 6️ Security Hardening
- Fixed base image versions
- Removed unnecessary packages
- Enforced non-root execution
- Used read-only filesystem
- Dropped Linux capabilities
- Applied container security flags

---

## Skills Demonstrated

- Writing optimized Dockerfiles
- Reducing container image size
- Implementing secure container practices
- Using multi-stage builds effectively
- Improving build performance with caching
- Debugging and inspecting image layers
- Running containers with hardened runtime flags
