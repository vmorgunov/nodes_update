#!/bin/bash

wget https://get.gear.rs/gear-nightly-linux-x86_64.tar.xz
sudo tar -xvf gear-nightly-linux-x86_64.tar.xz
rm gear-nightly-linux-x86_64.tar.xz
sudo systemctl restart gear
