#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/ollan/subtitle_translator.git /app
   
cd /app
git pull /app

if [ ! -f /app/st.cfg ]; then
    echo "40 yandex en sv" > /app/st.cfg
    echo -n "Enter your SubTranslater arguments in /app/st.cfg"
    exit
fi

if [ ! -f /app/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/yandex.key
    echo -n "Enter your Yandex key in /app/yandex.key"
    exit
fi

YAK=$(cat "/app/yandex.key")
echo -n "Yandex key: $YAK"
sed -i "11s/.*/YANDEX_API_KEY = \"$YAK\"/" /app/src/subTranslater.py

#python /app/run.py "/srt/TEST" $(< /app/st.cfg)

find /srt -name '*.srt' | while read line; do
    echo "Processing file '$line'"
done

#file pattern *.en.srt
