#!/bin/sh

if [ ! -e /owncloud/occ ]; then
	cp -rn /root/owncloud/* /owncloud
	chown -R www-data:www-data /owncloud
	chown -R www-data:www-data /data
fi

/run.sh
