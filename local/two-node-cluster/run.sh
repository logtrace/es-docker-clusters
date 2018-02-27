#!/bin/bash

hash docker 2>/dev/null || { echo >&2 "Please check if docker is installed"; exit 1; }

if hash docker-compose 2>/dev/null; then
    echo 'docker-compose detected'
else
    #Install docker-compose
    echo 'Installing docker-compose'
    sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

    #Set permissions
    sudo chmod +x /usr/local/bin/docker-compose
    echo 'Finished executing docker-compose'
fi

trap 'sudo docker-compose down' 2

#Start cluster
echo 'Starting elasticsearch cluster'
sudo docker-compose up