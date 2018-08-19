FROM ubuntu:18.04
LABEL author="Christian Elowsky <christian.elowsky@gmail.com>"

# Install cURL and NodeJS setup dependencies
RUN apt-get update && apt-get install -y curl software-properties-common gnupg

# Install dependencies (NodeJS, sqlite3, nginx)
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get update && apt-get install -y \
        git \
        nginx \
        nodejs \
        sqlite3 \
        unzip 

RUN mkdir -p /opt/khk-web
