#!/usr/bin/env bash
# Script to host a sample website from tooplate.com

# Get user inputs
set -e
read -p "Enter the web directory path (default /var/www/html): " web_dir
web_dir=${web_dir:-/var/www/html}

read -p "Enter the template URL (default https://www.tooplate.com/zip-templates/2108_dashboard.zip): " template_url
template_url=${template_url:-https://www.tooplate.com/zip-templates/2108_dashboard.zip}

read -p "Enter the output filename (default 2108_dashboard.zip): " output_file
output_file=${output_file:-2108_dashboard.zip}

# Check if web directory exists
if [ -d "$web_dir" ]; then
    cd "$web_dir" || exit 1
else
    echo "Web directory $web_dir does not exist. Installing Apache..."

    # Make sure install-apache.sh is executable
    if [ ! -x ./install-apache.sh ]; then
        chmod +x ./install-apache.sh
    fi

    # Run the Apache install script
    sudo ./install-apache.sh

    # After installation, check again
    if [ -d "$web_dir" ]; then
        cd "$web_dir" || exit 1
    else
        echo "Apache was installed but $web_dir still does not exist!"
        exit 1
    fi
fi

# Download template
echo "Downloading template..."

if [ -x "$(command -v wget)" ]; then
    sudo wget "$template_url" -O "$output_file"
elif [ -x "$(command -v curl)" ]; then
    sudo curl -L -o "$output_file" "$template_url"
else
    echo "Neither wget nor curl is installed. Installing wget..."

    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update && sudo apt-get install -y wget
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y wget
    else
        echo "Unsupported package manager. Install wget manually."
        exit 1
    fi

    sudo wget "$template_url" -O "$output_file"
fi

# Unzip template
if [ -x "$(command -v unzip)" ]; then
    sudo unzip "$output_file"
else
    echo "Unzip is not installed. Installing unzip..."

    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update && sudo apt-get install -y unzip
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y unzip
    else
        echo "Unsupported package manager. Install unzip manually."
        exit 1
    fi

    sudo unzip "$output_file"
fi

sudo rm "$output_file"

# Detect Apache service name
if [ -x "$(command -v apt-get)" ]; then
    SERVICE="apache2"
elif [ -x "$(command -v yum)" ]; then
    SERVICE="httpd"
else
    echo "Unsupported OS. Cannot manage Apache."
    exit 1
fi

# Restart or reload Apache
echo "What do you want to do with Apache?"
echo "1) Restart"
echo "2) Reload"
read -p "Enter 1 or 2: " choice

case "$choice" in
    1)
        echo "Restarting Apache..."
        sudo systemctl restart "$SERVICE"
        echo "Apache restarted successfully."
        ;;
    2)
        echo "Reloading Apache..."
        sudo systemctl reload "$SERVICE"
        echo "Apache reloaded successfully."
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac
