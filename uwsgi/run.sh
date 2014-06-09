#!/bin/bash

if [ -n "$PYPI_PORT" ]; then
	PYPI_FLAGS="-i ${PYPI_PORT/tcp:/http:}/root/pypi/"
fi

if find /env -maxdepth 0 -empty | read v; then
	virtualenv /env
fi


/env/bin/pip install uwsgi $PYPI_FLAGS

cd /code && /env/bin/pip install -r ${REQUIREMENTS_FILE:-requirements.txt} $PYPI_FLAGS

cd /code && /env/bin/uwsgi --virtualenv /env --chdir /code -w ${WSGI_MODULE:-wsgi:application} --uwsgi-socket 0.0.0.0:5000

