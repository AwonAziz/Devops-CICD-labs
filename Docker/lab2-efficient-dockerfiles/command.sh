## 1️ Install Docker

```bash
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
newgrp docker
```

---

## 2️ Build Basic Node App

```bash
docker build -t simple-node-app:v1.0 .
docker run -d -p 3000:3000 --name simple-app simple-node-app:v1.0
docker logs simple-app
```

---

## 3️ Multi-Stage Build

```bash
docker build -f Dockerfile.single-stage -t typescript-app:single .
docker build -t typescript-app:multi .
docker images | grep typescript-app
```

---

## 4️ Flask Optimized Build

```bash
docker build -t flask-app:optimized .
docker run -d -p 5000:5000 --name flask-container flask-app:optimized
curl http://localhost:5000/health
```

---

## 5️ Advanced Build Arguments

```bash
docker build -f Dockerfile.configurable \
  --build-arg PYTHON_VERSION=3.10 \
  --build-arg APP_ENV=development \
  -t flask-app:dev .
```

---

## 6️ Analyze Image Layers

```bash
docker history flask-app:optimized
docker image inspect flask-app:optimized
```

---

## 7️ Security-Hardened Container

```bash
docker run -d \
  --read-only \
  --cap-drop ALL \
  --no-new-privileges \
  -p 5000:5000 \
  secure-app:latest
```

---

## 8️ Cleanup

```bash
docker stop $(docker ps -q)
docker rm $(docker ps -aq)
docker system df
```
