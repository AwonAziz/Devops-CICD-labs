echo "===== SYSTEM UPDATE ====="
sudo apt update && sudo apt upgrade -y

echo "===== INSTALL DOCKER ====="
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release apparmor-utils

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

echo "===== CONFIGURE USER NAMESPACE ====="
sudo useradd -r -s /bin/false dockeruser
echo "dockeruser:100000:65536" | sudo tee -a /etc/subuid
echo "dockeruser:100000:65536" | sudo tee -a /etc/subgid

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<EOF
{
  "userns-remap": "dockeruser"
}
EOF

sudo systemctl restart docker
docker info | grep -i namespace

echo "===== TEST NON-ROOT CONTAINER ====="
docker run --rm ubuntu:20.04 id

echo "===== CREATE SECCOMP PROFILE ====="
mkdir -p ~/docker-security-lab/seccomp

cat > ~/docker-security-lab/seccomp/restricted.json <<EOF
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": ["SCMP_ARCH_X86_64"],
  "syscalls": [
    {
      "names": ["read","write","exit","exit_group","brk","mmap","munmap","clone","execve"],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
EOF

docker run --rm \
--security-opt seccomp=~/docker-security-lab/seccomp/restricted.json \
ubuntu:20.04 echo "Seccomp Applied"

echo "===== CREATE APPARMOR PROFILE ====="
sudo tee /etc/apparmor.d/docker-restricted <<EOF
#include <tunables/global>

profile docker-restricted {
  #include <abstractions/base>
  deny mount,
  deny capability sys_admin,
}
EOF

sudo apparmor_parser -r /etc/apparmor.d/docker-restricted
sudo aa-status | grep docker-restricted

docker run --rm \
--security-opt apparmor=docker-restricted \
ubuntu:20.04 echo "AppArmor Applied"

echo "===== VULNERABILITY SCAN ====="
docker pull nginx:latest
docker scout cves nginx:latest || echo "Docker Scout requires login"

echo "===== RESOURCE LIMIT TEST ====="
docker run --rm --memory=128m --cpus="0.5" ubuntu:20.04 \
echo "Resource limits applied"

echo "===== HARDENED RUNTIME TEST ====="
docker run --rm \
--read-only \
--cap-drop ALL \
--security-opt no-new-privileges:true \
--pids-limit 100 \
--memory=256m \
ubuntu:20.04 echo "Hardened container launched"
