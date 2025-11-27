#!/bin/bash
# Script to install Apache HTTP Server on a Linux system
web=apache2
if [ -x "$(command -v apt-get)" ]; then
    # For Debian/Ubuntu systems
    sudo apt-get update
    sudo apt-get install -y $web
    sudo systemctl start $web
    sudo systemctl enable $web
elif [ -x "$(command -v yum)" ]; then
    # For RHEL/CentOS systems
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
else
    echo "Unsupported package manager. Please install Apache manually."
    exit 1
fi