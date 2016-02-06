#!/bin/bash
docker run -d --name=sonarpotato -p 5050:5050 -p 8989:8989 -p 9117:9117 --net=htpc_network -e puid=1000 -e pgid=1000 -v /dev/rtc:/dev/rtc:ro -v /media/data/config/sonarr:/config -v /media/data/config/sonarr/jackett:/jackett -v /media/data:/media_data -v /media/data/config/sonarr/jackett/config:/root/.config/Jackett -v /media/data/config/couchpotato/:/config_couch sonarpotato
