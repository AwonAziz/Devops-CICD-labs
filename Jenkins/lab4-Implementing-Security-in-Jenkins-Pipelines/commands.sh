#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install Java (required for Jenkins)
sudo apt install -y openjdk-11-jdk
java -version

# Add Jenkins repository key
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# Add Jenkins repository
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Install Jenkins
sudo apt update
sudo apt install -y jenkins

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Verify Jenkins service
sudo systemctl status jenkins

# Get initial Jenkins admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Access Jenkins at http://localhost:8080"

# Test remote pipeline trigger (example)
curl -X POST "http://localhost:8080/job/development-pipeline/build?token=dev-build-token-123"

# Check build result
curl -s "http://localhost:8080/job/development-pipeline/lastBuild/api/json" | grep -o '"result":"[^"]*"'

# Create Jenkins security audit script
cat > jenkins_security_audit.sh << 'EOF'
#!/bin/bash
echo "=== Jenkins Security Audit ==="
echo "Date: $(date)"

echo "Jenkins Service Status:"
sudo systemctl status jenkins --no-pager

echo "Jenkins Processes:"
ps aux | grep jenkins | grep -v grep

echo "Network Ports:"
netstat -tlnp | grep 8080

echo "Checking Jenkins logs:"
sudo tail -20 /var/log/jenkins/jenkins.log 2>/dev/null

echo "=== Audit Complete ==="
EOF

chmod +x jenkins_security_audit.sh

# Run security audit
./jenkins_security_audit.sh
