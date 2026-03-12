# update system
sudo apt update && sudo apt upgrade -y

# install tools
sudo apt install -y wget curl git jq docker.io docker-compose

# start docker
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER

# create workspace
mkdir -p ~/buildkite-monitoring
cd ~/buildkite-monitoring

mkdir prometheus grafana alertmanager buildkite-exporter

# start monitoring stack
docker-compose up -d --build

# check containers
docker ps

# test metrics
curl http://localhost:8080/metrics

# test webhook
curl http://localhost:8081/health
