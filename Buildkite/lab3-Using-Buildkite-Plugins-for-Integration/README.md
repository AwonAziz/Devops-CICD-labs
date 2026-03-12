Learn how to use Buildkite plugins (especially Docker plugin) to run CI/CD tasks inside containers.

You will:

Install Docker and Buildkite Agent

Understand Buildkite plugins

Build a Docker-based pipeline

Run builds inside Docker containers

Validate and monitor pipelines

Step 1 — System Setup

Update system and install required tools.

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
curl wget git vim nano unzip \
software-properties-common \
apt-transport-https ca-certificates \
gnupg lsb-release
Step 2 — Install Docker

Add Docker repository and install Docker.

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list

sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

Enable Docker.

sudo systemctl start docker
sudo systemctl enable docker

Add user to docker group.

sudo usermod -aG docker $USER
newgrp docker

Test Docker.

docker --version
docker run hello-world
Step 3 — Install Buildkite Agent
curl -fsSL https://apt.buildkite.com/buildkite-agent/gpg.key \
| sudo gpg --dearmor -o /usr/share/keyrings/buildkite-agent.gpg

echo "deb [signed-by=/usr/share/keyrings/buildkite-agent.gpg] \
https://apt.buildkite.com/buildkite-agent stable main" \
| sudo tee /etc/apt/sources.list.d/buildkite-agent.list

sudo apt update
sudo apt install -y buildkite-agent

Create configuration.

sudo mkdir -p /etc/buildkite-agent

echo 'token="your-buildkite-token-here"' \
| sudo tee /etc/buildkite-agent/buildkite-agent.cfg
Step 4 — Create Lab Workspace
mkdir -p ~/buildkite-lab
cd ~/buildkite-lab

mkdir pipelines scripts logs sample-app
Step 5 — Create Sample Node.js App

Go to app directory.

cd ~/buildkite-lab/sample-app

Create package.json.

cat > package.json <<EOF
{
 "name":"buildkite-demo",
 "version":"1.0.0",
 "main":"app.js",
 "scripts":{
   "start":"node app.js",
   "test":"node test.js"
 }
}
EOF

Create app file.

cat > app.js <<EOF
const express=require("express")
const app=express()

app.get("/",(req,res)=>{
res.json({message:"Hello from Buildkite Docker"})
})

app.get("/health",(req,res)=>{
res.json({status:"healthy"})
})

app.listen(3000,()=>console.log("Server running"))
EOF

Create test file.

cat > test.js <<EOF
console.log("Running tests...")
console.log("Tests passed!")
EOF
Step 6 — Create Dockerfile
cat > Dockerfile <<EOF
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm","start"]
EOF

Build and run container.

docker build -t buildkite-demo .

docker run -d -p 3000:3000 buildkite-demo

Test application.

curl http://localhost:3000
Step 7 — Create Buildkite Pipeline

Go back to lab directory.

cd ~/buildkite-lab

Create pipeline.

cat > pipelines/docker-pipeline.yml <<EOF
steps:

- label: "Install and Test"
  plugins:
    - docker#v5.8.0:
        image: "node:18-alpine"
        workdir: /app
        volumes:
          - ".:/app"

  commands:
    - npm install
    - npm test

- label: "Build Docker Image"
  plugins:
    - docker#v5.8.0:
        image: "docker:24-dind"
        privileged: true
        volumes:
          - "/var/run/docker.sock:/var/run/docker.sock"
          - ".:/workspace"
        workdir: /workspace

  commands:
    - docker build -t buildkite-demo .
EOF
Step 8 — Simulate Pipeline Run

Create a simple script.

mkdir -p scripts
cat > scripts/run-pipeline.sh <<EOF
#!/bin/bash

echo "Simulating Buildkite pipeline..."

echo "Step 1: Install dependencies"
docker run --rm -v \$(pwd):/app -w /app node:18-alpine npm install

echo "Step 2: Run tests"
docker run --rm -v \$(pwd):/app -w /app node:18-alpine npm test

echo "Step 3: Build image"
docker build -t buildkite-demo .
EOF

Make executable.

chmod +x scripts/run-pipeline.sh

Run pipeline.

./scripts/run-pipeline.sh
Step 9 — Monitor Docker

Check containers.

docker ps

Check images.

docker images

Check logs.

docker logs <container_id>
