Learn how to run **parallel jobs** in a Concourse CI/CD pipeline and monitor their execution.

---

# Step 1 – Install Dependencies
Update the system and install required tools.

bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget curl docker.io docker-compose git nano
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker
Step 2 – Install Concourse with Docker

Create a working directory.

mkdir ~/concourse-lab4
cd ~/concourse-lab4

Create the Docker Compose file.

nano docker-compose.yml

Paste the provided docker-compose.yml configuration and save.

Start Concourse.

docker-compose up -d

Wait about 2 minutes for services to start.

Check running containers.

docker-compose ps
Step 3 – Install Fly CLI

Download Fly CLI.

wget http://localhost:8080/api/v1/cli?arch=amd64\&platform=linux -O fly
chmod +x fly
sudo mv fly /usr/local/bin/

Verify installation.

fly --version
Step 4 – Login to Concourse
fly -t tutorial login -c http://localhost:8080 -u admin -p admin

Verify connection.

fly -t tutorial teams
Step 5 – Create Project Structure
mkdir -p ~/parallel-jobs-lab/{pipelines,scripts,resources}
cd ~/parallel-jobs-lab

Create directories for scripts.

mkdir -p scripts/{build,test,deploy}
Step 6 – Create Pipeline

Create the pipeline file.

nano pipelines/parallel-jobs-pipeline.yml

Paste the provided parallel pipeline YAML configuration.

This pipeline includes:

Initialization job

Parallel build jobs

Parallel testing jobs

Final deployment preparation

Step 7 – Deploy the Pipeline

Set the pipeline.

fly -t tutorial set-pipeline -p parallel-jobs -c pipelines/parallel-jobs-pipeline.yml

Type y when prompted.

Unpause the pipeline.

fly -t tutorial unpause-pipeline -p parallel-jobs

Verify pipelines.

fly -t tutorial pipelines
Step 8 – Trigger Pipeline

Run the pipeline manually.

fly -t tutorial trigger-job -j parallel-jobs/initialize-pipeline

Monitor jobs.

fly -t tutorial jobs -p parallel-jobs
Step 9 – Monitor in Web UI

Open in browser:

http://localhost:8080

Login:

Username: admin
Password: admin

You will see multiple jobs running in parallel.

Result

You successfully:

Installed Concourse

Created a CI/CD pipeline

Executed multiple parallel jobs

Observed concurrent pipeline execution
