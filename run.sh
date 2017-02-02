#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/ollan/subtitle_translator.git /app
   
cd /app
git pull /app

if [ ! -f /app/st.cfg ]; then
    echo "40 yandex en sv" > /app/st.cfg
    echo "Enter your SubTranslater arguments in /app/st.cfg"
    exit
    #cp /app/src/subTranslater.py /app/src/subTranslater.py.org
fi

if [ ! -f /app/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/yandex.key
    echo "Enter your Yandex key in /app/yandex.key"
    exit
    #cp /app/src/subTranslater.py /app/src/subTranslater.py.org
fi

#if [ ! -f /app/src/subTranslater.py.org ]; then
   #cp /app/src/subTranslater.py /app/src/subTranslater.py.org
#fi

#cp /app/src/subTranslater.py.org /app/src/subTranslater.py

YAK=$(cat "/app/yandex.key")
#sed "s/#YAK/YANDEX_API_KEY = $YAK/g" /app/src/subTranslater.py > /app/src/subTranslater.py.new
#mv /app/src/subTranslater.py.new /app/src/subTranslater.py
sed -i "11s/.*/YANDEX_API_KEY = $YAK/" /app/src/subTranslater.py

python /app/run.py "/srt/TEST" $(< /app/st.cfg)

#file pattern *.en.srt
