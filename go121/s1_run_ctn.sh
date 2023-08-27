#!/usr/bin/env bash

dockerCtnName=go121
docker rm -f ${dockerCtnName} 2>/dev/null
docker run -dit --name ${dockerCtnName} daominah/go121
