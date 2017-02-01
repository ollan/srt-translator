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
    echo "40" >> /app/st.cfg
    echo "yandex" >> /app/st.cfg
    echo "en" >> /app/st.cfg
    echo "sv" >> /app/st.cfg
fi

python /app/run.py 
