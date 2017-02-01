#!/bin/bash

[[ ! -d "/app/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /app
   
cd /app
git pull /app

python /app/run.py 
