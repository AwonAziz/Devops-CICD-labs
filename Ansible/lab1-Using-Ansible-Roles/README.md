This lab focuses on building and using **Ansible roles** to automate the deployment and configuration of a web server. Roles help organize Ansible automation into reusable components by separating tasks, variables, templates, and handlers into a structured format.

In this exercise, a custom **Apache web server role** was created and applied to a local host using Ansible playbooks. The role installs Apache, configures a virtual host, deploys a templated web page, and manages the service lifecycle.

The lab demonstrates how roles simplify infrastructure automation and improve maintainability in larger automation projects.

---

## Key Concepts Practiced

- Understanding Ansible role structure
- Creating reusable infrastructure automation
- Organizing automation into tasks, handlers, templates, and variables
- Deploying applications using playbooks and roles
- Using Jinja2 templates for dynamic configuration
- Managing services with Ansible handlers
- Testing and validating role deployments

---

## Technologies Used

- Ansible
- Python3 / pip
- Apache Web Server
- Linux (Ubuntu)
- YAML
- Jinja2 templating

---

## Role Structure

The web server role follows the standard Ansible directory layout:
roles/
└── webserver/
├── tasks/
├── handlers/
├── templates/
├── files/
├── vars/
├── defaults/
├── meta/


Each directory is responsible for a specific part of the automation workflow.

---

## What the Role Automates

The custom role performs the following actions:

- Installs the Apache web server
- Starts and enables the Apache service
- Creates the web document root
- Deploys a dynamic HTML page using a template
- Configures the Apache virtual host
- Updates the listening port configuration
- Opens firewall access for HTTP traffic
- Verifies Apache configuration before applying changes

Handlers are used to automatically **restart or reload Apache** whenever configuration files change.

---

## Playbooks Used

Several playbooks were created during the lab:

**Basic deployment**

webserver-playbook.yml


Deploys the Apache server using the role.

**Customized deployment**


custom-webserver-playbook.yml


Overrides default variables such as:

- site title
- server name
- admin email

**Testing playbook**


test-webserver-role.yml


Validates that the role correctly installs and configures the web server.

---

## Verification

The deployment was verified using:


curl http://localhost


and by checking that Apache is listening on port **80**.

---

## What I Learned

- How to structure automation using Ansible roles
- How to use templates to generate dynamic configuration files
- How handlers manage service restarts automatically
- How roles improve reusability and organization in automation projects
- How to validate infrastructure automation using testing playbooks
