for D in `find . -maxdepth 1 -name "khk-*" -type d`
do
	sudo systemctl stop "${D#./}.service"
done
sudo killall node
