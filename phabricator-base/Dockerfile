FROM debian:jessie

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN useradd --system scm
RUN useradd --system phd

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	php5-mysql php5-gd php5-dev php5-curl php-apc php5-cli php5-json php5-ldap \
	git mercurial \
	sudo \
	supervisor

VOLUME ["/etc/supervisor/conf.d"]

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

