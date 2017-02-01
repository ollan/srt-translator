FROM python:2-slim
MAINTAINER Johan Axfors <johan@axfors.se>

RUN chmod +x /run.sh

VOLUME /usr/src/myapp /srt
CMD ["/run.sh"]
