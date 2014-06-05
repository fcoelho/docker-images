FROM debian:wheezy

RUN apt-get update && apt-get install -y python-pip

RUN pip install devpi-server

VOLUME  ["/cache"]

EXPOSE 3141

CMD ["/usr/local/bin/devpi-server", "--serverdir", "/cache", "--host", "0.0.0.0"]

