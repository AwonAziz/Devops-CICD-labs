echo "===== SYSTEM UPDATE ====="
sudo apt update && sudo apt upgrade -y

echo "===== INSTALLING REQUIRED PACKAGES ====="
sudo apt install -y wget unzip curl git tree jq python3

echo "===== INSTALLING TERRAFORM ====="
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.6.6_linux_amd64.zip
terraform version

echo "===== CREATING LAB DIRECTORY STRUCTURE ====="
mkdir -p ~/terraform-troubleshooting-lab
cd ~/terraform-troubleshooting-lab

mkdir -p scenario1-state-issues
mkdir -p scenario2-console-debugging
mkdir -p scenario3-error-handling
mkdir -p scenario4-advanced-troubleshooting

echo "===== ENABLE TERRAFORM DEBUG LOGGING SCRIPT ====="
cat > enable_terraform_logging.sh << 'EOF'
#!/bin/bash
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform-debug.log
echo "Terraform logging enabled at DEBUG level"
echo "Log file: terraform-debug.log"
EOF

chmod +x enable_terraform_logging.sh

echo "===== INITIALIZING GIT REPOSITORY ====="
git init
git add .
git commit -m "Initial structure for Terraform Troubleshooting Lab"

echo "===== LAB SETUP COMPLETE ====="
echo "You can now begin running scenario-based troubleshooting exercises."
