```bash
#!/bin/bash

echo "================================="
echo "Lab 6 - Pipeline Dependencies"
echo "================================="

echo "Updating system..."
sudo apt update

echo "Installing required packages..."
sudo apt install -y git docker.io curl wget nano vim python3 python3-pip

echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Adding user to Docker group..."
sudo usermod -aG docker $USER

echo "Installing GitLab Runner..."
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt install -y gitlab-runner

echo "Checking GitLab Runner version..."
gitlab-runner --version

echo "Creating project directory..."
mkdir -p ~/pipeline-dependencies-lab
cd ~/pipeline-dependencies-lab

echo "Creating directories..."
mkdir -p src tests scripts build

echo "Initializing Git repository..."
git init

echo "Creating Python application..."

cat > src/app.py << 'EOF'
def add(a,b):
    return a+b

def subtract(a,b):
    return a-b

def multiply(a,b):
    return a*b

def divide(a,b):
    if b==0:
        raise ValueError("Cannot divide by zero")
    return a/b

if __name__ == "__main__":
    print("Calculator Demo")
    print(add(5,3))
EOF

echo "Creating test file..."

cat > tests/test_app.py << 'EOF'
import sys, os
sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'src'))

from app import add, subtract, multiply, divide

def run_tests():
    assert add(2,3)==5
    assert subtract(5,3)==2
    assert multiply(4,5)==20
    assert divide(10,2)==5
    print("All tests passed!")

if __name__ == "__main__":
    run_tests()
EOF

chmod +x src/app.py tests/test_app.py

echo "Creating build script..."

cat > scripts/build.sh << 'EOF'
#!/bin/bash
echo "Starting build process..."
mkdir -p build
cp src/app.py build/
echo "Build complete."
EOF

echo "Creating security scan script..."

cat > scripts/security_scan.sh << 'EOF'
#!/bin/bash
echo "Running security scan..."
sleep 2
echo "No vulnerabilities found."
EOF

echo "Creating deployment script..."

cat > scripts/deploy.sh << 'EOF'
#!/bin/bash
echo "Deploying application..."
sleep 2
echo "Deployment completed."
EOF

chmod +x scripts/*.sh

echo "Creating pipeline simulation script..."

cat > simulate_pipeline.sh << 'EOF'
#!/bin/bash

echo "Simulating pipeline..."

./scripts/build.sh
python3 tests/test_app.py
./scripts/security_scan.sh
./scripts/deploy.sh

echo "Pipeline simulation complete."
EOF

chmod +x simulate_pipeline.sh

echo "Installing PyYAML for validation tools..."
pip3 install --user pyyaml

echo "Setup complete!"
echo "Navigate to the project directory:"
echo "cd ~/pipeline-dependencies-lab"
