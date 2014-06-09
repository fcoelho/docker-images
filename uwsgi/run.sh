#!/bin/bash

if [ -n "$PYPI_PORT" ]; then
	PYPI_FLAGS="-i ${PYPI_PORT/tcp:/http:}/root/pypi/"
fi

if find /data/env -maxdepth 0 -empty | read v; then
	virtualenv /data/env
fi

/data/env/bin/pip install uwsgi $PYPI_FLAGS

/data/env/bin/pip install -r ${REQUIREMENTS_FILE:-requirements.txt} $PYPI_FLAGS

/data/env/bin/uwsgi --virtualenv /data/env --chdir /data/code -w ${WSGI_MODULE:-wsgi:application} --uwsgi-socket 0.0.0.0:5000

