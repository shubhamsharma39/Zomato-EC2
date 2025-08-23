#!/bin/bash
set -euxo pipefail

# Update system
apt update -y

# Install Java (for Jenkins)
apt install -y fontconfig openjdk-17-jre

# Install Jenkins
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt update -y
apt install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# Install Docker
apt install -y docker.io
usermod -aG docker ubuntu
usermod -aG docker jenkins
systemctl restart docker
systemctl restart jenkins

# Install Trivy
apt install -y wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/trivy.list
apt update -y
apt install -y trivy

# AWS CLI
snap install aws-cli --classic
