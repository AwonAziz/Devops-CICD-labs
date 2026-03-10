This lab demonstrates how Jenkins functionality can be extended using plugins.  
Docker and Maven plugins were installed and integrated into Jenkins pipelines to automate containerized builds and Java project builds.

## Overview

The environment was prepared on a Linux machine by installing Java, Jenkins, Docker, and Maven.  
Jenkins plugins were then installed to enable integration with these tools and allow pipelines to perform container operations and Java builds.

Two types of pipelines were created:

- Docker-based pipeline
- Maven Java build pipeline

An advanced pipeline combining Docker and Maven was also tested.

## Docker Plugin Integration

The Docker plugin allows Jenkins pipelines to interact with Docker directly.

Key tasks performed:

- Installed Docker Engine
- Added the Jenkins user to the Docker group
- Installed Docker-related Jenkins plugins
- Configured Docker host connection inside Jenkins

A pipeline was created to:

- Check Docker installation
- Pull and run a container
- Build a custom Docker image
- Execute the container
- Clean up unused images

This demonstrated how Jenkins can automate container-based workflows.

## Maven Plugin Integration

The Maven plugin enables Jenkins to build Java projects using Apache Maven.

Key tasks performed:

- Installed Apache Maven on the system
- Installed Maven plugins in Jenkins
- Configured Maven and JDK in Global Tool Configuration

A sample Java project was created containing:

- a simple Java class
- unit tests using JUnit
- a Maven `pom.xml` build configuration

A pipeline was then created to:

- compile the project
- run automated tests
- package the application
- archive build artifacts

## Docker + Maven Integration

An advanced pipeline combined both tools by:

- building the Java project inside a Docker container
- packaging the application
- creating a Docker image for the application
- running the container to verify the build

This demonstrated how Jenkins pipelines can create **portable build environments using containers**.

## Key Concepts Learned

- Installing and managing Jenkins plugins
- Integrating Docker into Jenkins pipelines
- Automating Java builds using Maven
- Running builds inside containers
- Managing pipeline stages and artifacts
- Troubleshooting Jenkins plugin and build issues
