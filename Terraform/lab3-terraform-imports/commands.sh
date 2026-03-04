echo "===== SYSTEM UPDATE ====="
sudo apt update && sudo apt upgrade -y

echo "===== INSTALLING DEPENDENCIES ====="
sudo apt install -y curl unzip wget gnupg software-properties-common python3 python3-pip

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

echo "===== INSTALLING LOCALSTACK ====="
pip3 install localstack
echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
source ~/.bashrc

localstack --version

echo "===== STARTING LOCALSTACK ====="
localstack start -d
sleep 30

export AWS_ENDPOINT_URL=http://localhost:4566

echo "===== CREATING EXISTING S3 BUCKET ====="
aws s3 mb s3://my-existing-bucket --endpoint-url=$AWS_ENDPOINT_URL

echo "This file was created outside Terraform" > test-file.txt
aws s3 cp test-file.txt s3://my-existing-bucket/ --endpoint-url=$AWS_ENDPOINT_URL

aws s3api put-bucket-versioning \
  --bucket my-existing-bucket \
  --versioning-configuration Status=Enabled \
  --endpoint-url=$AWS_ENDPOINT_URL

echo "===== INITIALIZING TERRAFORM PROJECT ====="
mkdir terraform-import-lab
cd terraform-import-lab
terraform init

echo "===== IMPORT WORKFLOW READY ====="
echo "Now create your configuration files and run terraform import manually."

echo "===== COMMON STATE COMMANDS ====="
echo "terraform state list"
echo "terraform state show <resource>"
echo "terraform state rm <resource>"

echo "===== LAB SETUP COMPLETE ====="
