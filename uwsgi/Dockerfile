FROM google/python

RUN apt-get update && apt-get install -y --no-install-recommends libjpeg-dev libpng-dev
RUN virtualenv /env

RUN /env/bin/pip install uwsgi

VOLUME  ["/data"]

ADD run.sh /run.sh

EXPOSE 5000

CMD ["/run.sh"]
