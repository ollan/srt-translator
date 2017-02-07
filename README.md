# docker-srt-translator
Docker Container that translates SRT subtitle files.


Uses https://github.com/gunesmes/subtitle_translator


docker run --rm -v /opt/srttranslator:/app -v /media/srt:/srt --name=srt-translator ollan/srt-translator
