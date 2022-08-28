#!/bin/bash

cd lukso-l16-testnet/
sudo curl https://install.l16.lukso.network | sudo bash 
sudo lukso network update
sudo lukso network restart
sudo lukso network validator start