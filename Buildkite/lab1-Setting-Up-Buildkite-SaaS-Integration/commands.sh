#!/bin/bash

# UPDATE SYSTEM
sudo apt update
sudo apt install -y curl wget git build-essential

# INSTALL BUILDKITE AGENT
mkdir -p ~/buildkite
cd ~/buildkite

curl -Lf -o buildkite-agent https://github.com/buildkite/agent/releases/latest/download/buildkite-agent-linux-amd64
chmod +x buildkite-agent
sudo mv buildkite-agent /usr/local/bin/

buildkite-agent --version

# CREATE AGENT DIRECTORIES
sudo mkdir -p /etc/buildkite-agent
sudo useradd -r -s /bin/false buildkite-agent

sudo mkdir -p /var/lib/buildkite-agent
sudo mkdir -p /var/log/buildkite-agent

sudo chown -R buildkite-agent:buildkite-agent /var/lib/buildkite-agent
sudo chown -R buildkite-agent:buildkite-agent /var/log/buildkite-agent

# CREATE SAMPLE PROJECT
mkdir -p ~/sample-project
cd ~/sample-project

git init

# CREATE PIPELINE DIRECTORY
mkdir -p .buildkite

# INITIAL COMMIT
git add .
git config user.email "student@alnafi.com"
git config user.name "Lab Student"
git commit -m "Initial commit"
