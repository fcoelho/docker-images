FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y php5-fpm php5-apcu
RUN \
	sed -i "s/listen =.*/listen = 0.0.0.0:9000/g" /etc/php5/fpm/pool.d/www.conf && \
	sed -i "s/;daemonize.*/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

ADD wwwdata-sudo /etc/sudoers.d/wwwdata-sudo

ADD run.sh /run.sh
ADD phpfpm-supervisor.conf /etc/supervisor/conf.d/phpfpm-supervisor.conf

EXPOSE 9000

# Use phabricator-base's CMD
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

