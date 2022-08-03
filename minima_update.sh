#!/bin/bash

sudo systemctl stop minima_9001
rm -rf /home/minima/.minima*
sudo systemctl start minima_9001
sudo journalctl -f -n 100 -u minima_9001