#!/bin/bash
set -e

echo "=== Updating packages ==="
sudo apt-get update -y && sudo apt-get upgrade -y

echo "=== Installing Docker if not present ==="
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing..."
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
      https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    echo "Docker installed. Please logout/login to apply group changes."
else
    echo "Docker already installed"
fi

echo "=== Installing kubectl ==="
if ! command -v kubectl &> /dev/null
then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
else
    echo "kubectl already installed"
fi

echo "=== Installing Minikube ==="
if ! command -v minikube &> /dev/null
then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
else
    echo "Minikube already installed"
fi

echo "=== Starting Minikube with Docker driver ==="
minikube start --driver=docker

echo "=== Verifying Minikube ==="
minikube status
kubectl get nodes

echo "=== Minikube setup completed successfully! ==="