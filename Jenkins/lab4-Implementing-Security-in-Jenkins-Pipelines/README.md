This lab focuses on securing Jenkins by implementing role-based access control (RBAC), managing user permissions, and applying security best practices to CI/CD pipelines.

## Overview

A Jenkins server was installed on a Linux machine and configured with security plugins to enable advanced access control features. The environment was then secured by creating multiple users with different permission levels and restricting access to specific Jenkins jobs.

The lab demonstrates how Jenkins administrators can enforce security policies and ensure that users only access resources relevant to their roles.

## Role-Based Access Control (RBAC)

The **Role-based Authorization Strategy plugin** was used to implement RBAC.  
Different roles were created to represent typical DevOps team members:

- **Admin** – full system administration access  
- **Manager** – can manage and configure jobs  
- **Developer** – can build and view development pipelines  
- **Tester** – can run and monitor testing pipelines  

Each user account was assigned a role that defines what actions they are allowed to perform inside Jenkins.

## Project-Level Security

To demonstrate fine-grained access control, multiple pipeline jobs were created:

- `development-pipeline`
- `testing-pipeline`
- `production-pipeline`

Project roles were configured so that:

- Developers can access development pipelines
- Testers can access testing pipelines
- Managers can access all pipelines

This ensures teams only interact with the pipelines relevant to their responsibilities.

## Additional Security Measures

Several security features were implemented to strengthen the Jenkins environment:

- Remote build triggers protected with authentication tokens
- CSRF protection enabled to prevent malicious requests
- Agent-to-master access control configured
- Security monitoring and audit scripts created

These controls help protect Jenkins from unauthorized access and misuse.

## Security Monitoring

Scripts were created to monitor Jenkins security and audit system configuration.  
These scripts can check:

- Jenkins service status
- running processes and network ports
- installed security plugins
- recent security events in Jenkins logs

This allows administrators to continuously verify that Jenkins is operating securely.

## Key Concepts Learned

- Installing Jenkins securely on Linux
- Implementing Role-Based Access Control (RBAC)
- Managing Jenkins users and permissions
- Restricting access to pipelines using project roles
- Securing remote build triggers
- Monitoring Jenkins security activity
