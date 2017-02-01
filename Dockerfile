FROM python:2-slim
MAINTAINER Johan Axfors <johan@axfors.se>

RUN chmod 755 /*.sh

VOLUME /usr/src/myapp /srt
CMD ["/run.sh"]
