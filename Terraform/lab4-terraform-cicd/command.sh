echo "===== SYSTEM UPDATE ====="
sudo apt update && sudo apt upgrade -y

echo "===== INSTALLING DEPENDENCIES ====="
sudo apt install -y curl wget unzip git software-properties-common

echo "===== INSTALLING TERRAFORM ====="
wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip
unzip terraform_1.6.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_1.6.6_linux_amd64.zip
terraform version

echo "===== INSTALLING GITHUB CLI ====="
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y
gh --version

echo "===== INSTALLING DOCKER ====="
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker
docker --version

echo "===== CONFIGURE GIT ====="
git config --global user.name "Harvey Benidict"
git config --global user.email "your.email@example.com"

echo "===== AUTHENTICATE WITH GITHUB ====="
gh auth login

echo "===== CREATE PROJECT STRUCTURE ====="
mkdir -p ~/terraform-cicd-lab
cd ~/terraform-cicd-lab
mkdir -p terraform scripts .github/workflows

touch terraform/{main.tf,variables.tf,outputs.tf,terraform.tf}
touch README.md .gitignore

echo "===== INITIALIZE GIT REPOSITORY ====="
git init
git add .
git commit -m "Initial Terraform CI/CD structure"

echo "===== CREATE GITHUB REPOSITORY ====="
gh repo create terraform-cicd-lab --public --description "Terraform CI/CD Automation with GitHub Actions"
git branch -M main
git remote add origin https://github.com/$(gh api user --jq .login)/terraform-cicd-lab.git
git push -u origin main

echo "===== LOCAL TERRAFORM TEST ====="
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
cd ..

echo "===== LAB SETUP COMPLETE ====="
