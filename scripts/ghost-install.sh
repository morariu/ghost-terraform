#!/bin/bash -xe

# Output log at /var/log/user-data.log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

    # Update packages
    sudo apt-get update -y
    sleep 3m
    
    # Install Nginx
    sudo apt-get install -y nginx 

    # Add the NodeSource APT repository for Node 12
    sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash

    # Install Node.js && npm
    sudo apt-get install -y nodejs
    sudo npm install npm@latest -g

    # Install Ghost-CLI
    sudo npm install ghost-cli@latest -g

    # Give permission to ubuntu user, create directory 
    sudo chown -R ubuntu:ubuntu /var/www/
    sudo -u ubuntu mkdir -p /var/www/blog && cd /var/www/blog

    # Install Ghost, cannot be run via root (user data default)
    sudo -u ubuntu ghost install \
        --url      "${url}" \
        --admin-url "${url_admin}" \
        --db "${db_type}" \
        --dbhost "${database_endpoint}" \
        --dbuser "${rds_master_username}" \
        --dbpass "${rds_master_password}" \
        --dbname "${dbname}" \
        --process systemd \
        --no-prompt