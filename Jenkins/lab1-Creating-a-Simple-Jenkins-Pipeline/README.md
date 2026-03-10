This lab demonstrates how to install Jenkins and create a basic CI/CD pipeline for a Node.js application using Jenkins declarative pipelines.

## Overview

The environment was prepared on a Linux machine by installing Java, Jenkins, Git, and Node.js.  
A simple Node.js application was created and stored in a local Git repository, which Jenkins used as the pipeline source.

The pipeline was defined using a **Jenkinsfile**, allowing automated build, test, and deployment stages.

## Pipeline Structure

The Jenkins pipeline was organized into several stages:

### Checkout
The pipeline verifies that the project files exist and confirms the working directory.

### Build
Dependencies are installed using `npm install` to prepare the application.

### Test
The application is started temporarily and automated tests are executed using Mocha.  
After testing, the application process is stopped.

### Deploy
The pipeline simulates deployment by copying application files to a deployment directory.

## Jenkins Configuration

Jenkins was configured through the web interface:

- Installed suggested plugins
- Created an admin user
- Configured Node.js in **Global Tool Configuration**
- Created a pipeline job that pulls the project from the local Git repository

The pipeline job executes the **Jenkinsfile** stored in the project directory.

## Enhanced Pipeline Features

The pipeline was later improved by adding:

- environment variables
- pipeline parameters
- conditional deployment stages
- optional test execution

These features allow deployments to different environments such as **staging** or **production**.

## Key Concepts Learned

- Jenkins installation and setup on Linux
- Declarative pipeline syntax
- Using a Jenkinsfile for CI/CD automation
- Running build, test, and deployment stages
- Managing pipelines with parameters and environment variables
- Troubleshooting Jenkins builds
