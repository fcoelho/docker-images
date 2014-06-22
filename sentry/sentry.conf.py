from sentry.conf.server import *

import os

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '/data/sentry.db',
    }
}

SENTRY_URL_PREFIX = os.getenv('SENTRY_URL_PREFIX')

SENTRY_WEB_HOST = '0.0.0.0'
SENTRY_WEB_PORT = 80
SENTRY_WEB_OPTIONS = {
    'workers': 3,  # the number of gunicorn workers
    'limit_request_line': 0,  # required for raven-js
    'secure_scheme_headers': {'X-FORWARDED-PROTO': 'https'},
}

#################
## Mail Server ##
#################

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

SECRET_KEY = os.getenv('SENTRY_SECRET_KEY')

try:
	from sentry_local_settings import *
except ImportError:
	print 'NO LOCAL SETTINGS'
