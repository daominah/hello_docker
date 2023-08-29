#!/usr/bin/env bash

dockerCtnName=nodejs18
docker rm -f ${dockerCtnName} 2>/dev/null
docker run -dit --name ${dockerCtnName} daominah/nodejs18
