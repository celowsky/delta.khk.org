for D in `find . -maxdepth 1 -name "khk-*" -type d`
do
	sudo systemctl start "${D#./}.service"
done
