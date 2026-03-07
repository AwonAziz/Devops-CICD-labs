This lab focuses on **automating cloud infrastructure provisioning using Ansible and AWS**.  
Instead of manually creating resources in the AWS console, infrastructure was deployed programmatically using **Infrastructure as Code (IaC)** principles.

Using Ansible playbooks, AWS resources such as **EC2 instances, security groups, and key pairs** were automatically created, verified, and managed.

---

## Key Concepts Practiced

- Infrastructure as Code (IaC)
- Automating AWS resource provisioning with Ansible
- Configuring AWS credentials for programmatic access
- Creating and managing EC2 instances
- Managing AWS security groups
- Automating SSH key pair creation
- Infrastructure verification and cleanup automation

---

## Technologies Used

- Ansible
- AWS EC2
- AWS Security Groups
- Python3 / pip
- boto3 & botocore
- YAML
- Linux

---

## Lab Workflow

### 1. Environment Setup

A Linux environment was prepared and required tools were installed:

- Python3
- pip
- Ansible
- AWS SDK libraries (`boto3`, `botocore`)
- Ansible AWS collection (`amazon.aws`)

---

### 2. AWS Authentication

AWS programmatic access was configured by creating credential files in:

~/.aws/credentials
~/.aws/config


These credentials allow Ansible to communicate with AWS APIs.

---

### 3. Testing AWS Connectivity

A small playbook was used to verify the connection to AWS by retrieving the **AWS account identity**.

---

### 4. EC2 Key Pair Creation

An SSH key pair was generated locally and uploaded to AWS using an Ansible playbook.

This allows secure SSH access to the EC2 instance once it is launched.

---

### 5. Security Group Configuration

A security group was created with rules allowing:

- SSH access (port 22)
- HTTP access (port 80)
- HTTPS access (port 443)

---

### 6. EC2 Instance Provisioning

An EC2 instance was provisioned using an Ansible playbook with:

- Amazon Linux 2 AMI
- `t2.micro` instance type
- configured SSH key pair
- associated security group
- infrastructure tagging

The playbook also recorded instance details such as:

- Instance ID
- Public IP
- Private IP
- Instance state

---

### 7. Infrastructure Verification

Additional playbooks were used to verify:

- EC2 instance status
- security group configuration
- SSH connectivity to the instance

---

### 8. Infrastructure Cleanup

A cleanup playbook was created to automatically remove:

- EC2 instances
- security groups
- key pairs

This ensures cloud resources do not remain running and incur costs.

---

## Example SSH Access

After provisioning, the instance can be accessed using:


ssh -i ~/.ssh/aws-lab-key ec2-user@PUBLIC_IP


---

## What I Learned

This lab demonstrated how cloud infrastructure can be **fully automated using Ansible**.  
Instead of manually provisioning servers, DevOps engineers can define infrastructure using reusable code.

Key takeaways:

- Infrastructure as Code improves consistency and repeatability
- Ansible can directly manage AWS resources
- Automation reduces configuration errors
- Infrastructure lifecycle (create → verify → destroy) can be managed programmatically
