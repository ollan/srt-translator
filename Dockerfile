FROM python:2-slim
MAINTAINER Johan Axfors <johan@axfors.se>


RUN apt-get update && \ 
    apt-get -yq install \
		bash && \
	apt-get upgrade && \
	apt-get autoremove && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archive/*.deb

ADD ./run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME /usr/src/myapp /srt
CMD ["/run.sh"]
