# docker-srt-translator
Docker Container that translates SRT subtitle files.


##Information
Translation library: https://github.com/gunesmes/subtitle_translator

Docker Contaniner: https://hub.docker.com/r/ollan/srt-translator/

##Usage

```
docker run --rm -v /opt/srttranslator:/app -v /media/srt:/srt --name=srt-translator ollan/srt-translator`
```

##Directories & Files

/srt: Directory where SRT-files is searched for recursively

/app: Directory where config and source files is stored

/app/config/st.cfg: Subtitle Translator arguments

Example file:
```
40 yandex en sv
```

/app/config/ste.cfg: Subtitle Translator library output file suffix

Example file:
```
_en_to_sv.srt
```

/app/config/foe.cfg: SRT Translator output file extension

Example file:
```
sv.srt
```

/app/config/fie.cfg: SRT Translator input file extension. Files to search for in /srt.

Example file:
```
en.srt
```

/app/config/yandex.key: SRT Translator input file extension. Files to search for in /srt.

Example file:
```
4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```
