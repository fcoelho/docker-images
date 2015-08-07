FROM centos:centos7

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN useradd --system scm
RUN useradd --system phd

RUN yum install -y epel-release
RUN yum install -y \
    git            \
    mercurial      \
    php-cli        \
    php-curl       \
    php-devel      \
    php-gd         \
    php-json       \
    php-ldap       \
    php-process    \
    php-mysql      \
    sudo           \
    supervisor

COPY rebase.rc /etc/mercurial/hgrc.d/rebase.rc

ENV PHABRICATOR_VERSION=stable \
    LIBPHUTIL_VERSION=stable   \
    ARCANIST_VERSION=stable

RUN cd /opt && \
    git clone --branch $PHABRICATOR_VERSION https://secure.phabricator.com/diffusion/P/phabricator.git && \
    git clone --branch $LIBPHUTIL_VERSION https://secure.phabricator.com/diffusion/PHU/libphutil.git && \
    git clone --branch $ARCANIST_VERSION https://secure.phabricator.com/diffusion/ARC/arcanist.git
