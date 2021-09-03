#!/bin/bash
#add line to crontab 
cronline="0 1 * * * /home/mendel/OSIDS/detection/coral_devboard_mini/clean.sh"
(sudo crontab -u root -l; echo "$cronline" ) | sudo crontab -u root -

sudo docker restart frigate
sudo docker restart node-red
