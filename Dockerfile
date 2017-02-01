FROM python:2-onbuild
MAINTAINER Johan Axfors <johan@axfors.se>

VOLUME /usr/src/app /srt
CMD ["/run"]
