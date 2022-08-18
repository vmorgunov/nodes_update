#!/bin/bash

systemctl stop suid
sudo rm -rf /var/sui/db
systemctl restart suid

echo -e '\n\e[42m SUI Datebase was successfully updated \e[0m\n' && sleep 1