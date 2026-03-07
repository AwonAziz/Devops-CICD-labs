#!/bin/bash

echo "Updating system..."
sudo apt update

echo "Installing required packages..."
sudo apt install -y python3 python3-pip ansible

echo "Installing AWS Python SDK..."
pip3 install boto3 botocore

echo "Installing Ansible AWS collection..."
ansible-galaxy collection install amazon.aws

echo "Verifying Ansible installation..."
ansible --version

echo "Creating AWS configuration directory..."
mkdir -p ~/.aws

echo "Setting correct permissions..."
chmod 700 ~/.aws

echo "Creating working directory..."
mkdir -p ~/ansible-aws-lab
cd ~/ansible-aws-lab

echo "Generating SSH key for EC2 access..."
ssh-keygen -t rsa -b 2048 -f ~/.ssh/aws-lab-key -N ""

echo "Displaying public key..."
cat ~/.ssh/aws-lab-key.pub

echo "Testing AWS connectivity..."
ansible-playbook test-aws-connection.yml

echo "Creating AWS key pair..."
ansible-playbook create-keypair.yml

echo "Creating security group..."
ansible-playbook create-security-group.yml

echo "Provisioning EC2 instance..."
ansible-playbook provision-ec2.yml

echo "Provisioning full infrastructure..."
ansible-playbook complete-infrastructure.yml

echo "Verifying infrastructure..."
ansible-playbook verify-infrastructure.yml

echo "Waiting for instance readiness..."
sleep 30

echo "Fetching public IP..."
PUBLIC_IP=$(grep "Public IP:" instance-info.txt | cut -d' ' -f3)

echo "Testing SSH connection..."
ssh -i ~/.ssh/aws-lab-key -o StrictHostKeyChecking=no ec2-user@$PUBLIC_IP "echo 'SSH connection successful!'"

echo "To cleanup infrastructure run:"
echo "ansible-playbook cleanup-infrastructure.yml"
