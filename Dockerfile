FROM python:2-slim
MAINTAINER Johan Axfors <johan@axfors.se>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \ 
    apt-get -y install \
                git \
		bash && \
	apt-get autoremove && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archive/*.deb

RUN mkdir -p /usr/src/myapp

ADD ./run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME /usr/src/myapp /srt
CMD ["/run.sh"]
