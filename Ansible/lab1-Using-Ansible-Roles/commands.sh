echo "Updating system..."
sudo apt update

# Install dependencies
echo "Installing Python and utilities..."
sudo apt install -y python3 python3-pip software-properties-common curl wget

# Install Ansible
echo "Installing Ansible..."
pip3 install ansible

# Add pip binaries to PATH
echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
source ~/.bashrc

# Verify installation
ansible --version

# Create working directory
mkdir -p ~/ansible-lab4
cd ~/ansible-lab4

# Create Ansible configuration
cat > ansible.cfg << EOF
[defaults]
inventory = inventory
host_key_checking = False
EOF

# Create inventory
cat > inventory << EOF
[webservers]
localhost ansible_connection=local
EOF

# Test connection
ansible all -m ping

# Create role directory structure
mkdir -p roles/webserver/{tasks,handlers,templates,files,vars,defaults,meta}

touch roles/webserver/tasks/main.yml
touch roles/webserver/handlers/main.yml
touch roles/webserver/vars/main.yml
touch roles/webserver/defaults/main.yml
touch roles/webserver/meta/main.yml

# Create playbook
cat > webserver-playbook.yml << EOF
---
- name: Deploy Web Server using Ansible Role
  hosts: webservers
  become: yes

  roles:
    - webserver
EOF

# Run playbook
ansible-playbook webserver-playbook.yml

# Verify Apache service
sudo systemctl status apache2

# Test web server
curl http://localhost

# Check port listening
sudo ss -tlnp | grep :80
