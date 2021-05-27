#!/usr/bin/env bash

export serviceDir=$PWD
export dockerImgTag=daominah/mysql8


cd ${serviceDir}/image && docker build --tag=${dockerImgTag} .
if [[ $? -eq 0 ]]; then
    echo "built image ${dockerImgTag} with cache"
else
    cd ${serviceDir}/image && docker build --tag=${dockerImgTag} --no-cache .
    echo "built image with no cache"
fi
