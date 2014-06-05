FROM debian:wheezy

RUN apt-get update && \
	apt-get install -y \
		python-pip python-dev \
		libjpeg-dev libpng-dev

RUN pip install uwsgi

VOLUME  ["/data"]

ADD run.sh /run.sh

EXPOSE 5000

CMD ["/run.sh"]
