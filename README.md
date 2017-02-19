# docker-srt-translator
Docker Container that translates SRT subtitle files.


Translation library: https://github.com/gunesmes/subtitle_translator

Docker Contaniner: https://hub.docker.com/r/ollan/srt-translator/

##Usage

```
docker run --rm -v /opt/srttranslator:/app -v /media/srt:/srt --name=srt-translator ollan/srt-translator`
```

##Directories & Files

srt: Directory where SRT-files is searched for recursively

app: Directory where config and source files is stored


