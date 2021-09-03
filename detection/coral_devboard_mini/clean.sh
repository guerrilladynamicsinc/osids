#!/bin/bash
#runs on the coral
#clean out the frigate log file every 4 hours to prevent disk becoming full
sudo docker exec -it frigate rm /var/log/nginx/access.log
sudo docker exec -it frigate rm /var/log/nginx/error.log
