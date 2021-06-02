#!/usr/bin/env bash

set -x

export dockerImgTag=redis:6-buster
export dockerCtnName=redis6
export redisPort=6379

echo "stop and remove old container ${dockerCtnName}"
docker rm -f ${dockerCtnName}

echo "run redis container"
docker run -dit --name ${dockerCtnName} --restart always \
    -p ${redisPort}:6379 \
    ${dockerImgTag}

#echo "run redis container disabled persistence"
#docker run -dit --name ${dockerCtnName} --restart always \
#    -p ${redisPort}:6379 \
#    ${dockerImgTag} bash -c "rm -f /data/dump.rdb && redis-server --save ''"
