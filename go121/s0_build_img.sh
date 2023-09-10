#!/usr/bin/env bash

export dockerImgTag=daominah/go121
# option: `--progress=plain`, `--no-cache`
docker build --tag=$dockerImgTag .
export isBuiltWell=$?
if [[ $isBuiltWell -eq 0 ]]; then
    echo "built image $dockerImgTag with cache"
else
    echo "error when build image, try to build --no-cache"
    docker build --tag=$dockerImgTag --no-cache .
    export isBuiltWell=$?
fi

if [[ $isBuiltWell -eq 0 ]]; then
    echo "successfully built, pushing it to to hub.docker.com"
    # docker push $dockerImgTag
else
    echo "fail to build image $dockerImgTag"
fi
