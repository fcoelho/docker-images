#!/bin/bash

ADMIN_DOMAIN=${ADMIN_DOMAIN:-docker}
CONFIG_DIR_ADMIN_ID=${CONFIG_DIG_ADMIN_ID:-admin}
CONFIG_DIR_ADMIN_PWD=${CONFIG_DIR_ADMIN_PWD:-}
FULL_MACHINE_NAME=${FULL_MACHINE_NAME:-ldap.docker}
ROOT_DN=${ROOT_DN:-"cn=Directory Manager"}
ROOT_DN_PWD=${ROOT_DN_PWD:-}
ROOT_DN_PWD_HASHED=
SERVER_IDENTIFIER=${SERVER_IDENTIFIER:-ldap}
SUFFIX=${SUFFIX:-dc=docker}

function generate_new_password {
	local say_new_password=false

	echo "-----------------------------------------------------------------"
	echo "  Generating new passwords..."
	if [ -z "$CONFIG_DIR_ADMIN_PWD" -o -z "$ROOT_DN_PWD" ]; then
		say_new_password=true
	fi

	if [ -z "$CONFIG_DIR_ADMIN_PWD" ]; then
		CONFIG_DIR_ADMIN_PWD=$(tr -cd [:alnum:] < /dev/urandom | head -c 32)
		echo "    Password for $CONFIG_DIR_ADMIN_ID: $CONFIG_DIR_ADMIN_PWD"
	fi

	if [ -z "$ROOT_DN_PWD" ]; then
		ROOT_DN_PWD=$(tr -cd [:alnum:] < /dev/urandom | head -c 32)
		echo "    Password for $ROOT_DN: $ROOT_DN_PWD"
	fi


	ROOT_DN_PWD_HASHED=$(pwdhash -s SSHA512 $ROOT_DN_PWD)

	echo '  Done!'
	echo "-----------------------------------------------------------------"
}

function replace_environment {
	for var in ADMIN_DOMAIN CONFIG_DIR_ADMIN_ID CONFIG_DIR_ADMIN_PWD \
		FULL_MACHINE_NAME ROOT_DN ROOT_DN_PWD ROOT_DN_PWD_HASHED \
		SERVER_IDENTIFIER SUFFIX
	do
		sed -i "s#\b$var\b#${!var}#g" $1
	done
}

function fix_permissions {
	# This should be called every time a container is created, because
	# some folders won't have the necessary permissions when starting a
	# new container. These are set after a yum install and setup-ds-admin,
	# which aren't called everytime a container is created
	chown nobody:nobody -R /var/lib/dirsrv
	chown nobody:nobody -R /var/run/dirsrv
	chown nobody:nobody -R /var/lock/dirsrv
	chown nobody:nobody -R /var/log/dirsrv
	chown nobody:nobody -R /usr/share/dirsrv

	# For whatever reason /dev/shm is 0700 for root on centos:centos6,
	# making the setup fail miserably
	chmod 777 /dev/shm
}

function setup_389_server {
	# restore the backup, volumes are now running
	rm -rf /etc/dirsrv/*
	mv /backup/etc-dirsrv/* /etc/dirsrv

	rm -rf /usr/share/dirsrv/*
	mv /backup/usr-share-dirsrv/* /usr/share/dirsrv

	rm -rf /backup

	generate_new_password
	replace_environment /tmp/ds-setup.inf

	setup-ds-admin.pl --silent --file /tmp/ds-setup.inf
	setup-ds-dsgw

	# setup-ds-admin.pl automatically starts these services, but we'll
	# control them from supervisord. TODO if someone knows a way to _not_
	# start the services after setup-ds-admin.pl, I'm interested in it
	service dirsrv stop
	service dirsrv-admin stop
}
	
fix_permissions

test -d /etc/dirsrv/slapd-${SERVER_IDENTIFIER} || setup_389_server

replace_environment /etc/supervisord.conf
/opt/python27/bin/supervisord -c /etc/supervisord.conf

