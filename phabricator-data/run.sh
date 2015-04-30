#!/bin/bash

# ensure correct permissions
chown phd:phd -R /var/repo

PHABRICATOR=/phabricator


function check_prerequisites {
	local fail=false

	for d in /phabricator /var/repo; do
		if [ ! -d $d ]; then
			echo "$d volume does not exist or is not a directory"
			fail=true
		fi
	done

	if [[ ! -v DB_PORT ]]; then
		echo "Database not configured, use the Docker Links, Luke\!"
		fail=true
	fi

	if [[ ( ! -v DB_PASS ) || ( ! -v DB_USER ) ]]; then
		echo "Database credentials missing, add them as environment variables:"
		printf "\tDB_PASS\n\tDB_USER\n"
		fail=true
	fi

	$fail && exit 1
}

function clone_repositories {
	for d in phabricator libphutil arcanist; do
		if [ -d $PHABRICATOR/$d ]; then
			(cd $PHABRICATOR/$d && git pull)
		else
			git clone git://github.com/facebook/$d.git $PHABRICATOR/$d
		fi
	done
}

function config_and_upgrade {
	config=$PHABRICATOR/phabricator/bin/config

	$config set mysql.pass "$DB_PASS"
	$config set mysql.user "$DB_USER"
	$config set mysql.host "db"

	$config set environment.append-paths '["/usr/lib/git-core"]'

	$config set phd.user phd
	$config set diffusion.ssh-user scm

	if [[ ( -v APHLICT_PORT ) && ( -v APHLICT_CLIENT_URI ) ]]; then
		$config set notification.client-uri "$APHLICT_CLIENT_URI"
		$config set notification.server-uri "http://aphlict:22281"
	fi

	$PHABRICATOR/phabricator/bin/storage upgrade --force
}

check_prerequisites
clone_repositories
config_and_upgrade

