#!/bin/bash

echo "Updating system packages..."
sudo apt update
sudo apt install -y python3 python3-pip curl wget git

echo "Installing Ansible..."
sudo pip3 install ansible

echo "Checking Ansible version..."
ansible --version

# Create lab workspace
mkdir -p ~/ansible-idempotence-lab
cd ~/ansible-idempotence-lab

# Create directory structure
mkdir -p playbooks files templates

# Create inventory
cat > inventory << EOF
[local]
localhost ansible_connection=local
EOF

# Create ansible configuration
cat > ansible.cfg << EOF
[defaults]
inventory = inventory
host_key_checking = False
stdout_callback = yaml
EOF

echo "Testing Ansible connection..."
ansible all -m ping

# Run non-idempotent example
echo "Running non-idempotent playbook..."
ansible-playbook playbooks/non-idempotent.yml

echo "Running again to demonstrate non-idempotence..."
ansible-playbook playbooks/non-idempotent.yml

# Run idempotent playbooks
echo "Running idempotent playbooks..."
ansible-playbook playbooks/idempotent-files.yml
ansible-playbook playbooks/idempotent-packages.yml
ansible-playbook playbooks/idempotent-services.yml

# Run master configuration
echo "Running master idempotent playbook..."
ansible-playbook playbooks/master-idempotent.yml --diff -v

echo "Running again to verify idempotence..."
ansible-playbook playbooks/master-idempotent.yml --diff

# Test web server
echo "Testing web server..."
curl http://localhost

# Check services
echo "Checking services..."
systemctl status nginx
systemctl status myapp
