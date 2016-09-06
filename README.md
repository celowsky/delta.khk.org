# khk-web
>*Created by Joseph Dailey*

##Purpose for Development
>This repo exists to provide a base installation and maintenance suite for all of the platform's services.

##Installation
```bash
# cd /opt
# git clone git@github.com:/KappaEtaKappa/khk-web.git
```
>It is important to place this repo in /opt of your server.

##Building
```bash
# ./build.sh
```
>This build script will pull and update all the sub-services, install all nginx proxy files, and execute any sub-service build files.

##General System Architecture
Each of the inclosed services run independantly on different system ports. These services are kept alive and controlled with systemd. Each of their designated subdomains are managed by an NGINX reverse proxy. A `.site` file is located in each respective sub-service and is installed at build-time to nginx's system folder.

##Other tooling scripts
###Start All Services
```bash
# ./start-all.sh
```
###Restart All Services
```bash
# ./restart-all.sh
```
###Kill All Services
```bash
# ./kill-all.sh
```
###Reload Applications
```bash
# ./reload-apps.sh
```
This script will gather all applications [khk-ssa](https://github.com/KappaEtaKappa/khk-ssa) will provide. It does this by the `.application.sh` script in each of the sub-services.
###Reset Users
```bash
# ./reset-users.sh
```
This script will reload the users (currently admin and khk) This configuration is important as it manages privlege levels. The file does not contain the passwords but contains the hashes the of the known passwords. 



