ing basic tools..."
sudo apt install -y curl wget git vim nano

echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

docker --version

echo "Installing Docker Compose..."
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) \
-o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

echo "Creating project directory..."
mkdir -p ~/microservices-ecommerce
cd ~/microservices-ecommerce

echo "Creating service directories..."
mkdir -p services/user-service
mkdir -p services/product-service
mkdir -p services/order-service
mkdir -p services/api-gateway
mkdir -p services/frontend

mkdir -p database/init
mkdir -p monitoring
mkdir -p shared/nginx
mkdir -p logs

echo "Building service images..."
docker build -t user-service ./services/user-service
docker build -t product-service ./services/product-service
docker build -t order-service ./services/order-service
docker build -t api-gateway ./services/api-gateway
docker build -t frontend ./services/frontend

echo "Starting containers with Docker Compose..."
docker-compose up -d

echo "Checking running containers..."
docker ps

echo "Viewing container logs..."
docker-compose logs

echo "Stopping services..."
docker-compose down
