FROM ubuntu:quantal
MAINTAINER Lucas Carlson <lucas@rufy.com>

# Let's get serf
RUN apt-get update -q
RUN apt-get install -qy build-essential git supervisor unzip
ADD https://dl.bintray.com/mitchellh/serf/0.4.5_linux_amd64.zip serf.zip
ADD 0.4.5_SHA256SUMS 0.4.5_SHA256SUMS
RUN shasum -a 256 -c 0.4.5_SHA256SUMS

RUN unzip serf.zip
RUN rm serf.zip
RUN mv serf /usr/bin/
ADD /start.sh /start.sh
ADD /run.sh /run.sh
ADD /supervisord-serf.conf /etc/supervisor/conf.d/supervisord-serf.conf
RUN chmod 755 /*.sh

EXPOSE 7946 7373
CMD ["/run.sh"]
