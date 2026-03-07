#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y python3 python3-pip python3-venv git curl wget

echo "Installing additional packages..."
sudo apt install -y software-properties-common apt-transport-https ca-certificates

echo "Creating Ansible virtual environment..."
python3 -m venv ansible-env
source ansible-env/bin/activate

echo "Installing Ansible..."
pip install ansible

echo "Verifying Ansible installation..."
ansible --version

echo "Creating working directory..."
mkdir -p ~/ansible-lab
cd ~/ansible-lab

echo "Creating Ansible inventory..."
cat <<EOF > inventory.ini
[webservers]
localhost ansible_connection=local

[databases]
localhost ansible_connection=local

[all:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

echo "Creating Ansible configuration..."
cat <<EOF > ansible.cfg
[defaults]
inventory = inventory.ini
host_key_checking = False
stdout_callback = yaml
interpreter_python = auto_silent
EOF

echo "Testing Ansible connectivity..."
ansible all -m ping

echo "Checking system facts..."
ansible all -m setup | head -20

echo "Creating multi-tier application structure..."
mkdir -p ~/ansible-lab/multi-tier-app/{roles,group_vars,host_vars,files,templates}

cd ~/ansible-lab/multi-tier-app

echo "Creating role directories..."
mkdir -p roles/{database,webserver,application}/{tasks,handlers,templates,files,vars,defaults}

echo "Creating group variables directories..."
mkdir -p group_vars/{webservers,databases,all}

echo "Directory structure created successfully."

echo "Next step:"
echo "Create role tasks and templates, then run the Ansible playbooks to deploy the application stack."
