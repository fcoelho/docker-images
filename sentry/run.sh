#!/bin/bash

set -x

export PYTHONPATH=/data


if [ -n "$PYPI_PORT" ]; then
	PYPI_FLAGS="-i ${PYPI_PORT/tcp:/http:}/root/pypi/"
fi

if find /env -maxdepth 0 -empty | read v; then
	virtualenv /env
fi


/env/bin/pip install sentry $PYPI_FLAGS

if [ -f /data/requirements.txt ]; then
	/env/bin/pip install -r /data/requirements.txt $PYPI_FLAGS
fi

if [ ! -f /data/sentry.conf.py ]; then
	cp /sentry.conf.py /data/sentry.conf.py
fi

if [ ! -f /data/sentry.db ]; then
	cd /data && /env/bin/sentry --config=sentry.conf.py upgrade

	if [ -n "$ADMIN_USER" ] && [ -n "$ADMIN_EMAIL" ] && [ -n "$ADMIN_PASSWORD" ]; then
		/env/bin/sentry --config=sentry.conf.py shell <<EOF
from sentry.models import User
User.objects.create_superuser("$ADMIN_USER", "$ADMIN_EMAIL", "$ADMIN_PASSWORD")
EOF
		/env/bin/sentry --config=sentry.conf.py repair --owner=$ADMIN_USER
	fi
fi


cd /data && /env/bin/sentry --config=sentry.conf.py start

