#!/bin/bash
sqlite3 ./khk-ssa/khk-access/db.sqlite "DELETE FROM apps;"
for D in `find . -maxdepth 1 -name "khk-*" -type d`
do
	cd $D
	if [ -f .application.sh ]; then
		./.application.sh
	fi
	cd ..
done

