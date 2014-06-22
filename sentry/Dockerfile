FROM google/python

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

ADD run.sh /run.sh
ADD sentry.conf.py /sentry.conf.py

VOLUME ["/env", "/data"]

EXPOSE 80

CMD ["/run.sh"]
