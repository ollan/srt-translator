#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /app
   
cd /app
git pull /app

pip install goslate 
pip install time 
pip install requests 
pip install codecs
pip install sys

python /app/run.py 
