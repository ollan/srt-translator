#!/bin/bash

mkdir -p /app/config
mkdir -p /app/src

[[ ! -d "/app/src/.git" ]] && \
   git clone https://github.com/ollan/subtitle_translator.git /app/src
   
cd /app/src
git pull /app/src

if [ ! -f /app/config/st.cfg ]; then
    echo "40 yandex en sv" > /app/config/st.cfg
    echo "Enter your SubTranslater arguments in /app/config/st.cfg"
fi

if [ ! -f /app/config/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/config/yandex.key
    echo "Enter your Yandex key in /app/config/yandex.key"
fi

YAK=$(cat "/app/config/yandex.key")
echo "Yandex key: $YAK"
sed -i "13s/.*/YANDEX_API_KEY = \"$YAK\"/" /app/src/src/subTranslater.py

while inotifywait -r -e modify -e moved_to -e create /srt; do
   find /srt -name '*.srt' | while read filepath; do
      dirpath=$(dirname "$filepath")

      if [ 0 -lt $(ls "$dirpath"/*_*_to_*.srt 2>/dev/null | wc -w) ]; then
         echo "Already translated dir $dirpath"
      else
         echo "Translating subtitle file $filepath"
         encoding=`file -i "$filepath" | cut -f 2 -d";" | cut -f 2 -d=`
         echo "Encoding: $encoding"
         iconv -f "$encoding" -t utf-8 $filepath > $filepath.utf8
         #python /app/src/run.py "$dirpath" $(< /app/config/st.cfg) > /dev/null
         chmod -R 0777 "$dirpath"
      fi
   done
   sleep 60
done
