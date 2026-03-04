echo "===== INSTALLING TERRAFORM ====="

sudo apt update
sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository \
"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update
sudo apt install -y terraform

echo "===== VERIFY TERRAFORM VERSION ====="
terraform version


echo "===== CREATE LAB DIRECTORY STRUCTURE ====="
mkdir -p ~/hcl-fundamentals-lab/examples/{variables,advanced}
cd ~/hcl-fundamentals-lab/examples


echo "===== INITIALIZE BASIC EXAMPLE ====="
terraform init
terraform validate
terraform fmt


echo "===== TEST VARIABLES MODULE ====="
cd ~/hcl-fundamentals-lab/examples/variables
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

echo "===== DISPLAY OUTPUTS ====="
terraform output
terraform output -json server_configurations


echo "===== TEST ADVANCED MODULE ====="
cd ~/hcl-fundamentals-lab/examples/advanced

mkdir -p {users,environments,access,servers,backups,named,security,instances,applications}

terraform init
terraform validate
terraform plan
terraform apply -auto-approve


echo "===== REVIEW GENERATED FILES ====="
find . -name "*.json" -o -name "*.conf" | head -10


echo "===== TEST COMPLETE EXAMPLE ====="
cd ~/hcl-fundamentals-lab/complete-example

terraform init
terraform validate
terraform plan
terraform apply -auto-approve


echo "===== LAB COMPLETED SUCCESSFULLY ====="
