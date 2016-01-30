#!/bin/bash
docker run -d --name=sonarr -p 8989:8989 -p 9117:9117 --net=htpc_network -e puid=1000 -e pgid=1000 -v /dev/rtc:/dev/rtc:ro -v /home/cloudsto/sonarr:/config -v /home/cloudsto/sonarr/jackett:/jackett -v /media/data:/media_data -v /home/cloudsto/sonarr/jackett/config:/root/.config/Jackett  sonarpotato
