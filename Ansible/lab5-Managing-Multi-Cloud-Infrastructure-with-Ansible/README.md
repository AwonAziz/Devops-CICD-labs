This lab explores how **Ansible can be used to manage infrastructure across multiple cloud providers**.  
The goal is to provision and manage resources on **AWS, Microsoft Azure, and Google Cloud Platform (GCP)** using Infrastructure as Code (IaC).

Instead of manually configuring each cloud environment, Ansible playbooks automate the deployment process and allow centralized control of resources across different platforms.

---

## Key Concepts Practiced

- Multi-cloud infrastructure management
- Infrastructure as Code (IaC)
- Ansible playbooks for cloud provisioning
- Dynamic inventories for cloud resources
- Authentication and credential management
- Automated resource deployment across providers

---

## Technologies Used

- Ansible
- AWS EC2
- Microsoft Azure Virtual Machines
- Google Cloud Compute Engine
- Python
- YAML
- Linux

---

## Project Structure


multi-cloud-lab/
│
├── playbooks/
│ ├── aws-provision.yml
│ ├── azure-provision.yml
│ ├── gcp-provision.yml
│ ├── multi-cloud-deploy.yml
│ ├── multi-cloud-manage.yml
│ └── multi-cloud-cleanup.yml
│
├── inventories/
│ ├── aws_ec2.yml
│ ├── azure_rm.yml
│ ├── gcp_compute.yml
│ └── multi-cloud-inventory.sh
│
├── credentials/
│ ├── aws-key.pem
│ ├── azure_credentials.yml
│ └── gcp-key.json
│
├── group_vars/
│ ├── cloud_aws/
│ ├── cloud_azure/
│ └── cloud_gcp/
│
└── ansible.cfg


---

## Deployment Workflow

1. Install Ansible and cloud provider SDKs
2. Configure credentials for AWS, Azure, and GCP
3. Create provisioning playbooks for each cloud provider
4. Deploy infrastructure using Ansible playbooks
5. Use dynamic inventories to discover cloud instances
6. Manage instances across providers using automation

---

## Example Commands

Deploy infrastructure to all clouds:


ansible-playbook playbooks/multi-cloud-deploy.yml


Deploy to a specific cloud:


ansible-playbook playbooks/multi-cloud-deploy.yml --tags aws
ansible-playbook playbooks/multi-cloud-deploy.yml --tags azure
ansible-playbook playbooks/multi-cloud-deploy.yml --tags gcp


Verify discovered instances:


ansible-inventory -i inventories/aws_ec2.yml --list


---

## What I Learned

This lab demonstrates how automation tools like Ansible can simplify the management of **complex multi-cloud environments**.

Key takeaways:

- Infrastructure can be managed across multiple providers from a single tool
- Dynamic inventories allow automatic discovery of cloud resources
- Playbooks enable repeatable and scalable infrastructure deployment
- Multi-cloud strategies improve flexibility and portability
