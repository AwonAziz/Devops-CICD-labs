echo "===== SYSTEM UPDATE ====="
sudo apt update && sudo apt upgrade -y

echo "===== INSTALLING DEPENDENCIES ====="
sudo apt install -y wget unzip curl git tree

echo "===== INSTALLING TERRAFORM ====="
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.6.6_linux_amd64.zip

terraform version

echo "===== INSTALLING AWS CLI ====="
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

aws --version

echo "===== CREATING PROJECT STRUCTURE ====="
mkdir -p ~/terraform-modules-lab
cd ~/terraform-modules-lab

mkdir -p modules/ec2-instance
mkdir -p environments/{dev,test,prod}
mkdir -p test-configurations

tree . || find . -type d | sort

echo "===== INITIALIZING DEVELOPMENT ENVIRONMENT ====="
cd environments/dev
terraform init
terraform validate
terraform plan

echo "===== INITIALIZING TEST ENVIRONMENT ====="
cd ../test
terraform init
terraform validate
terraform plan

echo "===== INITIALIZING PRODUCTION ENVIRONMENT ====="
cd ../prod
terraform init
terraform validate
terraform plan

echo "===== MODULE VALIDATION TEST ====="
cd ../../test-configurations
terraform init
terraform validate
terraform plan

echo "===== LAB SETUP COMPLETED ====="
