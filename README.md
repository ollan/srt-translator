# docker-srt-translator
Docker container that translates SRT subtitle files.


##Information
Translation library: https://github.com/gunesmes/subtitle_translator

Docker container: https://hub.docker.com/r/ollan/srt-translator/

##Usage

```
docker run --rm -v /opt/srttranslator:/app -v /media/srt:/srt --name=srt-translator ollan/srt-translator
```

##Directories & Files

/srt: Directory where SRT-files is searched for recursively


/app: Directory where config and source files is stored


/app/config/st.cfg

Subtitle Translator library arguments.

Example file:
```
40 yandex en sv
```


/app/config/ste.cfg

Subtitle Translator library output file suffix.

Example file:
```
_en_to_sv.srt
```


/app/config/foe.cfg

SRT Translator (this Docker container) output file extension.

Example file:
```
sv.srt
```


/app/config/fie.cfg

SRT Translator (this Docker container) input file extension. File extension to search for in /srt directory.

Example file:
```
en.srt
```


/app/config/yandex.key

Subtitle Translator library Yandex key.

Example file:
```
4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```
