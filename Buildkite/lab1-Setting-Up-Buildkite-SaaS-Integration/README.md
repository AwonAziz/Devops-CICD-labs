Buildkite SaaS Integration

## Objective

Set up a **Buildkite agent** on a Linux machine and connect it to the **Buildkite cloud platform** to run CI/CD jobs.

---

# Step 1 – Install Dependencies

Update system and install required tools.

```
sudo apt update
sudo apt install -y curl wget git build-essential
```

Verify:

```
curl --version
git --version
```

---

# Step 2 – Install Buildkite Agent

```
mkdir -p ~/buildkite
cd ~/buildkite

curl -Lf -o buildkite-agent https://github.com/buildkite/agent/releases/latest/download/buildkite-agent-linux-amd64
chmod +x buildkite-agent

sudo mv buildkite-agent /usr/local/bin/
```

Check installation:

```
buildkite-agent --version
```

---

# Step 3 – Setup Agent Configuration

Create required directories.

```
sudo mkdir -p /etc/buildkite-agent
sudo useradd -r -s /bin/false buildkite-agent

sudo mkdir -p /var/lib/buildkite-agent
sudo mkdir -p /var/log/buildkite-agent

sudo chown -R buildkite-agent:buildkite-agent /var/lib/buildkite-agent
sudo chown -R buildkite-agent:buildkite-agent /var/log/buildkite-agent
```

Create configuration file:

```
sudo nano /etc/buildkite-agent/buildkite-agent.cfg
```

Add:

```
token="YOUR_AGENT_TOKEN"
name="lab-agent"
tags="environment=lab"
build-path="/var/lib/buildkite-agent/builds"
```

---

# Step 4 – Start Buildkite Agent

Create and start the service.

```
sudo systemctl daemon-reload
sudo systemctl enable buildkite-agent
sudo systemctl start buildkite-agent
```

Check status:

```
sudo systemctl status buildkite-agent
```

View logs:

```
sudo journalctl -u buildkite-agent -f
```

---

# Step 5 – Create Sample Project

```
mkdir -p ~/sample-project
cd ~/sample-project
git init
```

Create files:

```
app.py
test_app.py
.buildkite/pipeline.yml
```

Commit project.

```
git add .
git config user.email "student@alnafi.com"
git config user.name "Lab Student"
git commit -m "Initial project"
```

---

# Step 6 – Create Pipeline in Buildkite

In the Buildkite dashboard:

1. Go to **Pipelines**
2. Click **New Pipeline**
3. Set repository:

```
file:///home/USER/sample-project
```

4. Pipeline file:

```
.buildkite/pipeline.yml
```

5. Add agent tag:

```
environment=lab
```

---

# Step 7 – Run Pipeline

Trigger a build from the Buildkite dashboard.

Monitor logs:

```
sudo journalctl -u buildkite-agent -f
```

View results in the **Buildkite web interface**.

---

# Key Insights

* Buildkite runs jobs using **local agents**.
* The **agent token connects the machine to Buildkite cloud**.
* Pipelines are defined using **YAML files**.
* Agents can be targeted using **tags**.

---

# Takeaways

* Installed a **Buildkite agent**
* Connected it to **Buildkite SaaS**
* Created a **CI pipeline**
* Executed builds using a **local machine**
