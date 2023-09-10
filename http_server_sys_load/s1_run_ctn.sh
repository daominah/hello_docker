#!/usr/bin/env bash

set -x

export dockerImgTag=daominah/http_server_sys_load
export dockerCtnName=http_server_sys_load
docker rm -f ${dockerCtnName} 2>/dev/null
docker run -dit --restart=always --name $dockerCtnName -p 21864:21864 $dockerImgTag

set +x
