#!/bin/bash

PHABRICATOR=/phabricator/phabricator

cd $PHABRICATOR/support/aphlict/server
if ! npm view ws version &> /dev/null; then
	npm install ws
fi

sudo -u phd /phabricator/phabricator/bin/aphlict start