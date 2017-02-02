#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/ollan/subtitle_translator.git /app
   
cd /app
git pull /app

if [ ! -f /app/st.cfg ]; then
    echo "40 yandex en sv" > /app/st.cfg
    echo "Enter your SubTranslater arguments in /app/st.cfg\n"
    exit
fi

if [ ! -f /app/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/yandex.key
    echo "Enter your Yandex key in /app/yandex.key\n"
    exit
fi

YAK=$(cat "/app/yandex.key")
echo "Yandex key: $YAK\n"
sed -i "13s/.*/YANDEX_API_KEY = \"$YAK\"/" /app/src/subTranslater.py

find /srt -name '*.srt' | while read filepath; do
    if [ ! -f "$(dirname "$filepath")/*_to_*.srt" ]; then
      echo "Processing directory $(dirname "$filepath")\n"
      python /app/run.py "$(dirname "$filepath")" $(< /app/st.cfg)
    else
       echo "Already processed directory $(dirname "$filepath")\n"
    fi
done
