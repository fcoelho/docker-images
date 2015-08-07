FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN yum install -y openssh-server rsyslog

COPY sshd_config /etc/sshd/sshd_config
COPY phabricator-ssh-hook.sh /usr/lib/phabricator-ssh-hook.sh
COPY scm-sudo /etc/sudoers.d/scm-sudo
COPY sshd-supervisor.ini /etc/supervisord.d/sshd-supervisor.ini

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

