#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/ollan/subtitle_translator.git /app
   
cd /app
git pull /app

if [ ! -f /app/st.cfg ]; then
    echo "40 yandex en sv" > /app/st.cfg
    echo "Enter your SubTranslater arguments in /app/st.cfg"
    exit
fi

if [ ! -f /app/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/yandex.key
    echo "Enter your Yandex key in /app/yandex.key"
    exit
fi

YAK=$(cat "/app/yandex.key")
echo "Yandex key: $YAK"
sed -i "13s/.*/YANDEX_API_KEY = \"$YAK\"/" /app/src/subTranslater.py

find /srt -name '*.srt' | while read filepath; do
   dirpath=$(dirname "$filepath")
   #echo "$dirpath/*_to_*.srt"
   pattern="$dirpath/*.srt"
   echo "Pattern: $pattern"
   if (( `ls "$pattern"* 2> /dev/null|wc -l` ));then
   #if [ -f ${pattern[0]} ]; then
    #if ls "$dirpath/*_to_*.srt" > /dev/null 2>&1; then 
    #if [ ! -f "$(dirname "$filepath")/*_to_*.srt" ]; then
      echo "Already processed directory $dirpath"
    else
      echo "Processing directory $(dirname "$filepath")"
      #python /app/run.py "$dirpath" $(< /app/st.cfg)
    fi
done
