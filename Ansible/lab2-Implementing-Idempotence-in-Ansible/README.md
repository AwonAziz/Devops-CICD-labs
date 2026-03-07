This lab explores the concept of **idempotence in Ansible automation**.  
Idempotence ensures that running an automation task multiple times results in the **same system state**, preventing unintended changes or duplicate configurations.

During this lab, several playbooks were created to demonstrate both **non-idempotent and idempotent automation approaches**. The exercises show how proper use of Ansible modules ensures consistent infrastructure configuration.

---

## Key Concepts Practiced

- Understanding idempotence in configuration management
- Identifying non-idempotent automation tasks
- Using Ansible modules instead of shell commands
- Ensuring predictable automation results
- Managing files, packages, and services idempotently
- Testing automation by running playbooks multiple times
- Applying best practices for infrastructure automation

---

## Technologies Used

- Ansible
- Python3 / pip
- Linux (Ubuntu)
- YAML
- Nginx Web Server

---

## Lab Workflow

The lab was completed in several stages.

### 1. Environment Setup

A Linux environment was prepared and Ansible was installed using pip.

### 2. Non-Idempotent Example

A playbook was created using shell commands that produced different results on every run, such as:

- Appending timestamps to files
- Creating directories with timestamps
- Creating random users

This demonstrated how poorly designed automation leads to unpredictable system changes.

### 3. Idempotent Playbooks

Several playbooks were developed using proper Ansible modules:

- **File management** using `file`, `copy`, and `lineinfile`
- **Package management** using the `apt` module
- **Service management** using `systemd`

These tasks ensure that the desired configuration exists **without repeating unnecessary changes**.

### 4. Master Idempotent Configuration

A comprehensive playbook was created that:

- Installs required packages
- Creates users and groups
- Configures application directories
- Deploys configuration files
- Configures and starts services
- Deploys a test web page
- Verifies system state after deployment

### 5. Idempotence Testing

Automation was verified by running playbooks multiple times and confirming that:

changed=0


appears after the initial configuration run.

---

## Verification

System functionality was verified using:


curl http://localhost

systemctl status nginx
systemctl status myapp


File permissions and ownership were also validated.

---

## What I Learned

This lab reinforced several important DevOps principles:

- Automation must be **repeatable and predictable**
- Ansible modules should be used instead of shell commands whenever possible
- Idempotent playbooks prevent configuration drift
- Handlers help manage service changes efficiently
- Testing automation multiple times ensures reliability

