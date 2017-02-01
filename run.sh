#!/bin/bash

[[ ! -d "/usr/scr/myapp/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /usr/scr/myapp
   
git pull /usr/scr/myapp

python --version
