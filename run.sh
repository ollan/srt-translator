#!/bin/bash

mkdir -p /app/config
mkdir -p /app/src

[[ ! -d "/app/src/.git" ]] && \
   git clone https://github.com/ollan/subtitle_translator.git /app/src
   
cd /app/src
git pull /app/src

if [ ! -f /app/config/st.cfg ]; then
    echo "40 yandex en sv" > /app/config/st.cfg
    echo "Enter SubTranslater arguments in /app/config/st.cfg"
fi

args=$(cat "/app/config/st.cfg")
echo "Arguments: $args"

if [ ! -f /app/config/fsp.cfg ]; then
    echo "*.en.srt" > /app/config/fsp.cfg
    echo "Enter SubTranslater file search pattern in /app/config/fsp.cfg"
fi

fsp=$(cat "/app/config/fsp.cfg")
echo "File search pattern: $fsp"


if [ ! -f /app/config/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/config/yandex.key
    echo "Enter your Yandex key in /app/config/yandex.key"
fi

YAK=$(cat "/app/config/yandex.key")
echo "Yandex key: $YAK"
sed -i "13s/.*/YANDEX_API_KEY = \"$YAK\"/" /app/src/src/subTranslater.py

while inotifywait -r -e modify -e moved_to -e create /srt; do
   find /srt -name "$fsp" | while read filepath; do
      
      dirpath="$(dirname "$filepath")/translated"
      filename=$(filename "$filepath")
      echo "Directory: $dirpath"
      echo "File name: $filename"
      
      if [ 0 -lt $(ls "$dirpath"/*_*_to_*.srt 2>/dev/null | wc -w) ]; then
         echo "Already translated dir $dirpath"
      else
         echo "Translating subtitle file $filepath"
         encoding=`file -i "$filepath" | cut -f 2 -d";" | cut -f 2 -d=`
         echo "Encoding: $encoding"
         iconv -f "$encoding" -t utf-8 "$filepath" > "$dirpath/$filename"
         python /app/src/run.py "$dirpath" "$args" > /dev/null
         rm "$dirpath/$filename"
         chmod -R 0777 "$dirpath"
      fi
   done
   sleep 60
done
