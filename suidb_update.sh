#!/bin/bash

systemctl stop suid
sudo rm -rf /var/sui/db
systemctl restart suid