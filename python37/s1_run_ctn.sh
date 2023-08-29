#!/usr/bin/env bash

dockerCtnName=python37
docker rm -f ${dockerCtnName} 2>/dev/null
docker run -dit --name ${dockerCtnName} daominah/python37
