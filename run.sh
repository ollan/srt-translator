#!/bin/bash

mkdir -p /usr/src/myapp

[[ ! -d "/usr/src/myapp/.git" ]] && \
   git clone https://github.com/gunesmes/subtitle_translator.git /usr/src/myapp
   
git pull /usr/src/myapp

python --version
