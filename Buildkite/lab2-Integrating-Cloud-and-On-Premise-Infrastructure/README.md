In this lab we simulate a **hybrid infrastructure** where CI/CD pipelines run across:

* **Cloud environment**
* **On-premise environment**

Using **Buildkite agents**, we create pipelines that build, test, and deploy applications in both environments.

---

# Architecture

Hybrid Pipeline Flow

1. Environment setup
2. Cloud application build & test
3. On-premise application build & security tests
4. Deploy applications using Docker
5. Run integration tests

---

# Prerequisites

* Linux system
* Git
* Docker
* Node.js
* Internet access

---

# Step 1 – System Setup

Update system and install dependencies.

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
curl wget git unzip \
software-properties-common \
apt-transport-https \
ca-certificates \
gnupg \
lsb-release
```

---

# Step 2 – Install Docker

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor \
-o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker

docker --version
```

---

# Step 3 – Install Node.js

```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt install -y nodejs

node --version
npm --version
```

---

# Step 4 – Create Lab Structure

```bash
mkdir -p ~/buildkite-hybrid-lab
cd ~/buildkite-hybrid-lab

mkdir -p agents pipelines apps configs scripts
mkdir -p environments/cloud environments/onpremise
```

---

# Step 5 – Install Buildkite Agent

```bash
wget https://github.com/buildkite/agent/releases/latest/download/buildkite-agent-linux-amd64.tar.gz

tar -xzf buildkite-agent-linux-amd64.tar.gz
mv buildkite-agent-linux-amd64 buildkite-agent

chmod +x buildkite-agent/buildkite-agent
```

Create agent folders:

```bash
mkdir -p agents/cloud-agent
mkdir -p agents/onpremise-agent
```

---

# Step 6 – Configure Agents

### Cloud Agent

`agents/cloud-agent/buildkite-agent.cfg`

```
token="YOUR_BUILDKITE_TOKEN"
name="cloud-agent-%hostname"

tags="environment=cloud,os=linux,docker=true"

build-path="/tmp/buildkite-builds"
hooks-path="hooks"
plugins-path="plugins"
```

### On-Premise Agent

`agents/onpremise-agent/buildkite-agent.cfg`

```
token="YOUR_BUILDKITE_TOKEN"
name="onpremise-agent-%hostname"

tags="environment=onpremise,os=linux,docker=true,secure=true"

build-path="/tmp/buildkite-builds-onprem"
hooks-path="hooks"
plugins-path="plugins"
```

---

# Step 7 – Start Agents

Cloud agent:

```bash
./buildkite-agent/buildkite-agent start \
--config agents/cloud-agent/buildkite-agent.cfg
```

On-premise agent:

```bash
./buildkite-agent/buildkite-agent start \
--config agents/onpremise-agent/buildkite-agent.cfg
```

---

# Step 8 – Create Sample Applications

Create two applications:

* `apps/cloud-app`
* `apps/onpremise-app`

Both applications:

* Node.js Express server
* Docker container
* Simple test scripts

Install dependencies:

```bash
cd apps/cloud-app
npm install

cd ../onpremise-app
npm install
```

---

# Step 9 – Hybrid Pipeline

Pipeline file:

```
pipelines/hybrid-pipeline.yml
```

Pipeline performs:

1. Setup
2. Cloud build & test
3. On-premise security test
4. Deploy containers
5. Integration test

---

# Step 10 – Run Hybrid Pipeline

Cloud pipeline:

```bash
./scripts/run-cloud-pipeline.sh
```

On-premise pipeline:

```bash
./scripts/run-onpremise-pipeline.sh
```

Full hybrid pipeline:

```bash
./scripts/run-hybrid-pipeline.sh
```

---

# Step 11 – Monitor Pipeline

```bash
./scripts/monitor-pipeline.sh
```

Check:

* Docker containers
* Docker images
* Application health
* System resources

---

# Expected Results

You should see:

* Docker images built
* Containers deployed
* Health checks passing
* Integration tests completed

Example endpoints:

```
http://localhost:3000
http://localhost:3001
```

---

# Key Concepts Learned

Hybrid CI/CD pipelines
Cloud vs On-Premise environments
Buildkite multi-agent setup
Docker based deployment
Environment-specific pipeline execution

---

# Cleanup

```bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```
