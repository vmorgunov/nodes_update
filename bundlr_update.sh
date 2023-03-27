#!/bin/bash

sudo apt update && sudo apt upgrade -y && npm upgrade --global yarn
cd $HOME/bundlr/validator-rust/ && \
git pull origin master && \
git submodule update --init --recursive && \
docker-compose up --build -d && \
docker-compose logs -f --tail 10

echo -e '\n\e[42m Bundlr was successfully updated \e[0m\n' && sleep 1