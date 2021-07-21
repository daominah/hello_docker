#!/usr/bin/env bash

export dockerImgTag=test_always_crash
export dockerCtnName=test_always_crash

docker build --tag=${dockerImgTag} .

docker rm -f ${dockerImgTag}
docker run -dit --name=${dockerImgTag} --restart always ${dockerImgTag}
