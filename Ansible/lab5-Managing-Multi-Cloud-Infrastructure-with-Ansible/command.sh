echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install python3 python3-pip python3-venv git curl unzip -y

echo "Verifying Python installation..."
python3 --version
pip3 --version

echo "Creating Python virtual environment..."
python3 -m venv ansible-env
source ansible-env/bin/activate

echo "Upgrading pip..."
pip install --upgrade pip

echo "Installing Ansible..."
pip install ansible

echo "Installing cloud provider SDKs..."
pip install boto3 botocore
pip install azure-cli azure-identity azure-mgmt-compute azure-mgmt-network azure-mgmt-resource
pip install google-auth google-cloud-compute

echo "Installing Ansible cloud collections..."
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install azure.azcollection
ansible-galaxy collection install google.cloud

echo "Checking Ansible installation..."
ansible --version

echo "Creating project directory..."
mkdir -p ~/multi-cloud-lab
cd ~/multi-cloud-lab

echo "Creating project structure..."
mkdir -p playbooks inventories group_vars host_vars roles credentials

echo "Creating initial configuration files..."
touch ansible.cfg
touch inventories/hosts.yml

echo "Testing Ansible environment..."
ansible localhost -m ping

echo "Testing dynamic inventories..."
ansible-inventory -i inventories/aws_ec2.yml --list
ansible-inventory -i inventories/azure_rm.yml --list
ansible-inventory -i inventories/gcp_compute.yml --list

echo "Running multi-cloud deployment..."
ansible-playbook playbooks/multi-cloud-deploy.yml

echo "Testing connectivity to instances..."
ansible all -i inventories/aws_ec2.yml -m ping
ansible all -i inventories/azure_rm.yml -m ping
ansible all -i inventories/gcp_compute.yml -m ping
