#!/bin/bash

if [ -n "$CELERY_MODULE" ]; then
	CELERY_APP="-A $CELERY_MODULE"
fi

if [ "$RUN_CELERY_BEAT" = "true" ]; then
	CELERY_BEAT="-B -s /tmp/celerybeat-schedule"
fi

cd /code && /env/bin/celery $CELERY_APP $CELERY_BEAT -c ${CELERY_CONCURRENCY:-1} -l ${CELERY_LOG_LEVEL:-info} -f ${CELERY_LOG_FILE:-/log/celery.log} worker

