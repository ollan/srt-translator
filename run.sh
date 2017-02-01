#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /app
   
cd /app
git pull /app

pip install goslate 
#pip install time 
pip install requests 
pip install codecs
#pip install sys

if [ ! -f /app/st.cfg ]; then
    echo "40 yandex en sv" > /app/st.cfg
fi

if [ ! -f /app/yandex.key ]; then
    echo "4trnsl.X.X.20170201T090054Z.XXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" > /app/yandex.key
fi

#if [ ! -f /app/src/subTranslater.py.org ]; then
#   cp /app/src/subTranslater.py /app/src/subTranslater.py.org
#fi

#sed -e "s/YANDEX_API_KEY = ""/YANDEX_API_KEY = "$(< /app/yandex.key)"/" /app/src/subTranslater.py > /app/src/subTranslater.py.tmp
#mv /app/src/subTranslater.py.tmp /app/src/subTranslater.py

#sed -i '10s/.*/ YANDEX_API_KEY = "$(< /app/yandex.key)" /' app/src/subTranslater.py

#python /app/run.py /srt/The.Hateful.Eight.2015.BDRip.x264-SPARKS/ $(< /app/st.cfg)
python /app/run.py "/srt/Shooter.S01E01.1080p.WEB-DL.DD5.1.H264-RARBG" 200 yandex en sv
