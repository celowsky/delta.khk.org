#!/bin/bash
#this script will handle the installation and rebuilding of all sub-projects of khk-web
#Joe Dailey

pwd=$(pwd)
ind="/opt/khk-web"
if [ "$pwd" != "$ind" ]; then
	echo !! Projects installed to the wrong directory.
	echo !! Projects must be installed to /opt/khk-web.
	exit 1
fi

	
if [ ! -d /opt/cert ]; then
	echo !! Missing /opt/cert/. These files are crucial for SSO with Google Drive.
	exit 1
fi


if [ ! -d /opt/tls ]; then
	echo !! Missing /opt/tls/. These files are crucial for HTTPS configuration.
	exit 1
fi

echo ::  Veryifying repo\(s\) are up to date.
git pull
git submodule init
git submodule update

#custom nginx conf
echo :: Installing main Nginx configuration
if ! which nginx > /dev/null 2>&1; then
	echo !! "Nginx not installed. Install and retry"
	exit 1
fi
sudo cp ./nginx/nginx.conf /etc/nginx/. -v
sudo mkdir /etc/nginx/sites -v

#sub-project installation and configuration
for D in `find . -maxdepth 1 -name "khk-*" -type d`
do
	echo :: Installing ${D#./}
	cd ${D}
  if /bin/bash build.sh; then
	  echo :: Successfully Installed ${D#./} 
  else
	  echo !! Failed to Install ${D#./}
  fi
  sudo systemctl restart nginx.service
done

/bin/bash reload-apps.sh
