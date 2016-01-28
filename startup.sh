#!/bin/bash
docker run -d --net=htpc_network --name=sonarpotato -p 5050:5050 -v /home/cloudsto/couchpotato/:/config sonarpotato python /opt/couchpotato/CouchPotato.py --data_dir=/config/data --config_file=/config/config.ini

