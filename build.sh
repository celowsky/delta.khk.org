#!/bin/bash
#this script will handle the installation and rebuilding of all sub-projects of khk-web
#Joe Dailey

pwd=$(pwd)
ind="/opt/khk-web"
if [ "$pwd" != "$ind" ]; then
	echo Projects installed to the wrong directory.
	echo Projects must be installed to /opt/khk-web.
	exit 1
fi

echo Veryifying repo\(s\) are up to date.
git pull
git submodule init
git submodule update

#custom nginx conf
echo Installing main Nginx configuration
if ! which nginx > /dev/null 2>&1; then
	echo "Nginx not installed. Install and retry"
	exit 1
fi
sudo cp ./nginx/nginx.conf /etc/nginx/.
sudo mkdir /etc/nginx/sites

#sub-project installation and configuration
for D in `find . -maxdepth 1 -name "khk-*" -type d`
do
	echo Installing configuration for ${D#./}
	if cd ${D}; then
		if /bin/bash build.sh; then
			cd cp
			#Move nginx conf into place and test configuration
			site=$(find . -maxdepth 1 -name "*.site")
			echo $site
			if [ -f $site ]; then
				sudo cp $site /etc/nginx/sites/.
		        else
				echo ${D#./} is missing a NGINX .site config. Please see the standards in the README.
				exit 1
			fi
			echo Testing NGINX site config for ${D#./}. \(Previously loaded sites may have already broken NGINX\) 
			sudo nginx -t
			service=$(find . -maxdepth 1 -name "*.service")
		        if [ -f $service ]; then
		                sudo cp $service /etc/systemd/system/.
				sudo systemctl daemon-reload
				sudo systemctl enable ${service#./}
				sudo systemctl start ${service#./}
		        else
		                echo Project located at ${D} is missing a systemd .service file. Please see the standards in the README.
		                exit 1
		        fi
			echo ${D#./} has been successfully install. Please verify successfull operation:
			sudo systemctl status ${service#./}
			cd ../../
		else
			exit 1
		fi
	else
		echo ${D#./} does not have a cp directory. Please see the standards in the README.
	fi

	sudo systemctl restart nginx.service
done
