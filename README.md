# docker-srt-translator
Docker Container that translates SRT subtitle files.


Translation library: https://github.com/gunesmes/subtitle_translator

Docker Hub: https://hub.docker.com/r/ollan/srt-translator/

Start: docker run --rm -v /opt/srttranslator:/app -v /media/srt:/srt --name=srt-translator ollan/srt-translator
