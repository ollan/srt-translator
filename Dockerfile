FROM python:2-slim
MAINTAINER Johan Axfors <johan@axfors.se>

ADD ./run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME /usr/src/myapp /srt
CMD ["/run.sh"]
