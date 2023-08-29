#!/usr/bin/env bash

export dockerImgTag=daominah/nodejs18

docker build --tag=$dockerImgTag .
docker push $dockerImgTag
