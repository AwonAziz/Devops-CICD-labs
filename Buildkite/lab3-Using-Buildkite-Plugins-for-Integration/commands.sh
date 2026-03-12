# update system
sudo apt update && sudo apt upgrade -y

# install tools
sudo apt install -y curl wget git vim nano unzip \
software-properties-common apt-transport-https \
ca-certificates gnupg lsb-release

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER
newgrp docker

docker run hello-world

# create workspace
mkdir -p ~/buildkite-lab
cd ~/buildkite-lab

mkdir pipelines scripts logs sample-app

# build container
docker build -t buildkite-demo .

docker run -d -p 3000:3000 buildkite-demo

# run pipeline simulation
chmod +x scripts/run-pipeline.sh
./scripts/run-pipeline.sh
