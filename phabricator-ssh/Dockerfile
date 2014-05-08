FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN apt-get install -y openssh-server rsyslog
RUN mkdir /var/run/sshd
RUN usermod -p NOPASS scm

ADD sshd_config /etc/sshd/sshd_config
ADD phabricator-ssh-hook.sh /usr/lib/phabricator-ssh-hook.sh
ADD scm-sudo /etc/sudoers.d/scm-sudo
ADD sshd-supervisor.conf /etc/supervisor/conf.d/sshd-supervisor.conf

EXPOSE 22

# Use phabricator-base's CMD
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

