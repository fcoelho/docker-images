#!/bin/bash

if [ -n "$PYPI_PORT" ]; then
	PYPI_FLAGS="-i ${PYPI_PORT/tcp:/http:}/root/pypi/"
fi

if find /env -maxdepth 0 -empty | read v; then
	virtualenv /env
fi

/env/bin/pip install -r /code/${REQUIREMENTS_FILE:-requirements.txt} $PYPI_FLAGS

chown celery:celery -R /log

su -p celery -c "/run-server.sh"
