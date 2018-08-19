#!/usr/bin/env bash
# Dev env created by Christian Elowsky <christian.elowsky@gmail.com>

SSH_KEY_NAME=id_rsa

# Install cURL and NodeJS setup dependencies
if ! command -v curl > /dev/null 2>&1; then
    apt-get update && apt-get install -y curl software-properties-common gnupg
fi

# Install dependencies (NodeJS, sqlite3, nginx)
if ! command -v node > /dev/null 2>&1; then
    curl -sL https://deb.nodesource.com/setup_8.x | bash - \
        && apt-get update && apt-get install -y \
            git \
            nginx \
            nodejs \
            sqlite3 \
            unzip 
fi
#
## Copy ssh key to access KHK repositories
#if [ ! -d /home/vagrant/.ssh ]; then
#    echo "hey fix your shit"
#    exit 1
#fi
#chmod 700 /home/vagrant/.ssh \
#    && chmod 600 /home/vagrant/.ssh/$SSH_KEY_NAME

# Install all KHK project dependencies
cd /opt/khk-web && bash build.sh

# Make vagrant ssh automatically change directory to project root
echo "cd /opt/khk-web" >> /home/vagrant/.bashrc
