#!/bin/bash

cd ${CODE_PATH:-/code}

if [ -n "$PYPI_PORT" ]; then
	PYPI_FLAGS="-i ${PYPI_PORT/tcp:/http:}/root/pypi/"
fi

virtualenv /env
/env/bin/pip install uwsgi

/env/bin/pip install -r ${REQUIREMENTS_FILE:-requirements.txt} $PYPI_FLAGS

/env/bin/uwsgi --virtualenv /env -w ${WSGI_MODULE:-wsgi:application} --uwsgi-socket 0.0.0.0:5000

