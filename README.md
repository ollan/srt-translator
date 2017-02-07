# docker-srt-translator
Docker Container that translates SRT subtitle files.


Uses https://github.com/gunesmes/subtitle_translator


docker run --rm -v /opt/docker/srttranslator:/app -v /media/usbdrive/downloads:/srt -e PGID=0 -e PUID=0 --name=srt-translator ollan/srt-translator
