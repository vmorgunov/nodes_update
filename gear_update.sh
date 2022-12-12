#!/bin/bash

sudo systemctl stop gear
/root/gear purge-chain -y
wget https://get.gear.rs/gear-nightly-linux-x86_64.tar.xz
sudo tar -xvf gear-nightly-linux-x86_64.tar.xz -C
rm gear-nightly-linux-x86_64.tar.xz
sudo systemctl start gear
echo -e '\n\e[42m GEAR was successfully updated \e[0m\n' && sleep 1