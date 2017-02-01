#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /app
   
cd /app
git pull /app

pip install goslate 
#pip install time 
pip install requests 
#pip install codecs
pip install sys

if [ ! -f /app/st.cfg ]; then
    echo "40 yandex en sv" > /app/st.cfg
fi

if [ ! -f /app/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/yandex.key
fi

sed -i '10s/.*/YANDEX_API_KEY = "$(< /app/yandex.key)"/' /app/src/subTranslater.py

python /app/run.py "$(< /app/st.cfg)"
