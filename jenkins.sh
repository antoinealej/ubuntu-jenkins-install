#!/bin/bash

# Definition of the error function
throwError () {
    echo "========================== $1 failed ==========================";
    exit 1;
}

# Update the system
sudo apt-get update || { throwError 'Update the system'; }

# Install Java
sudo add-apt-repository ppa:webupd8team/java || { throwError 'Install Java'; }

# Download Oracle Java 8 Installer
sudo apt-get update || { throwError 'Download Oracle Java 8 Installer update'; }
sudo apt-get install oracle-java8-installer || { throwError 'Download Oracle Java 8 Installer install'; }

# Configure Oracle JDK8 As Default
sudo apt-get install oracle-java8-set-default || { throwError 'Configure Oracle JDK8 As Default'; }

# Install Jenkins
cd /tmp && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - || { throwError 'Install Jenkins wget'; }
echo 'deb https://pkg.jenkins.io/debian-stable binary/' | sudo tee -a /etc/apt/sources.list.d/jenkins.list || { throwError 'Install Jenkins tee'; }
sudo apt-get update || { throwError 'Install Jenkins update'; }
sudo apt-get install jenkins || { throwError 'Install Jenkins install'; }

echo "Password : "
sudo cat /var/lib/jenkins/secrets/initialAdminPassword