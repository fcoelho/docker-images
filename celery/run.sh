#!/bin/bash

if [ -n "$PYPI_PORT" ]; then
	PYPI_FLAGS="-i ${PYPI_PORT/tcp:/http:}/root/pypi/"
fi

if find /env -maxdepth 0 -empty | read v; then
	virtualenv /env
fi

REQUIREMENTS_FILE=/code/${REQUIREMENTS_FILE:-requirements.txt}

if [ -f $REQUIREMENTS_FILE ]; then
	/env/bin/pip install -r $REQUIREMENTS_FILE $PYPI_FLAGS
else
	/env/bin/pip install celery $PYPI_FLAGS
fi

chown celery:celery -R /log

su -p celery -c "/run-server.sh"
