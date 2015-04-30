FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

# npm tries to call node instead of nodejs
RUN apt-get install -y nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN sudo -u phd mkdir -p /var/tmp/aphlict/pid
RUN touch /var/log/aphlict.log && chown phd:phd /var/log/aphlict.log
ADD aphlict-supervisor.conf /etc/supervisor/conf.d/aphlict-supervisor.conf
ADD run.sh /run.sh

VOLUME ["/phabricator"]

EXPOSE 22281

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
