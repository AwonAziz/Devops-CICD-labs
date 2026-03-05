echo "===== SYSTEM UPDATE ====="
sudo apt update && sudo apt upgrade -y

echo "===== INSTALLING DOCKER ====="
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

echo "===== VERIFY DOCKER ====="
docker --version
sudo docker run hello-world

echo "===== PULL SAMPLE IMAGES ====="
docker pull ubuntu:20.04
docker pull ubuntu:22.04
docker pull nginx:latest
docker pull python:3.9-slim
docker pull alpine:latest

echo "===== CREATE LAB DIRECTORY ====="
mkdir -p ~/docker-lab/webapp
cd ~/docker-lab/webapp

echo "===== CREATE SIMPLE DOCKERFILE ====="
cat > Dockerfile << 'EOF'
FROM python:3.9-slim
WORKDIR /app
RUN echo "Hello from Docker Lab 3" > index.html
EXPOSE 8080
CMD ["python3", "-m", "http.server", "8080"]
EOF

echo "===== BUILD IMAGE ====="
docker build -t my-webapp:v1.0 .

echo "===== RUN CONTAINER ====="
docker run -d --name webapp-container -p 8080:8080 my-webapp:v1.0

echo "===== LIST RUNNING CONTAINERS ====="
docker ps

echo "===== LAB SETUP COMPLETE ====="
echo "You can now continue experimenting with docker commit, docker diff, networking, and lifecycle commands."
