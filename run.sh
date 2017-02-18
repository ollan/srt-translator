#!/bin/bash

mkdir -p /app/config
mkdir -p /app/src

[[ ! -d "/app/src/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /app/src
   
cd /app/src
git pull /app/src

sed -i "8s/.*/"reload\(sys\)"/" /app/src/src/subTranslater.py
sed -i "9s/.*/"sys.setdefaultencoding\(\'utf8\'\)"/" /app/src/src/subTranslater.py

if [ ! -f /app/config/st.cfg ]; then
    echo "40 yandex en sv" > /app/config/st.cfg
    echo "Enter Subtite Translator arguments in /app/config/st.cfg"
fi

args=$(cat "/app/config/st.cfg")
echo "Subtite Translator arguments: $args"

if [ ! -f /app/config/ste.cfg ]; then
    echo "_en_to_sv.srt" > /app/config/ste.cfg
    echo "Enter Subtitle Translator ouput extension in /app/config/ste.cfg"
fi

ste=$(cat "/app/config/ste.cfg")
echo "Subtite Translator file output extension: $ste"

if [ ! -f /app/config/foe.cfg ]; then
    echo "sv.srt" > /app/config/foe.cfg
    echo "Enter file ouput extension in /app/config/foe.cfg"
fi

foe=$(cat "/app/config/foe.cfg")
echo "File output extension: $foe"

if [ ! -f /app/config/fie.cfg ]; then
    echo "en.srt" > /app/config/fie.cfg
    echo "Enter file input extension in /app/config/fie.cfg"
fi

fie=$(cat "/app/config/fie.cfg")
echo "File input extension: $fie"

if [ ! -f /app/config/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/config/yandex.key
    echo "Enter Yandex key in /app/config/yandex.key"
fi

YAK=$(cat "/app/config/yandex.key")
echo "Yandex key: $YAK"
sed -i "10s/.*/YANDEX_API_KEY = \"$YAK\"/" /app/src/src/subTranslater.py

while inotifywait -r -e modify -e moved_to -e create -e delete /srt; do
   find /srt -name "*.$fie" | while read filepath; do
      
      dirpath="$(dirname "$filepath")"
      echo "Directory: $dirpath"
      srtfile="$(basename $filepath)"
      srtfile="${srtfile%.$fie}.$foe"
      mkdir -p "$dirpath/srttranslator"
      echo "Output: $srtfile"
      
      if [ 0 -lt $(ls "$dirpath"/*."$foe" 2>/dev/null | wc -w) ]; then
         echo "Already translated: $dirpath"
      else
         echo "Translating: $filepath"
         encoding=`file -i "$filepath" | cut -f 2 -d";" | cut -f 2 -d=`
         echo "Encoding: $encoding"
         iconv -f "$encoding" -t utf-8 "$filepath" > "$dirpath/srttranslator/srttranslator.srt"
         python /app/src/run.py "$dirpath/srttranslator" $args > /dev/null
         
         cd "$dirpath/srttranslator"
         
         firstline=$(head -n 1 "srttranslator$ste")
         if [[ "$firstline" == "1"* ]]; then 
            echo "Correcting first line in srttranslator$ste"
            sed -i '1s/^/1\n/' "srttranslator$ste"
         fi
         
         cp "srttranslator$ste" "../$srtfile"
         rm -r "$dirpath/srttranslator/"
         chmod 0777 "../$srtfile"
      fi
   done
   sleep 60
done
