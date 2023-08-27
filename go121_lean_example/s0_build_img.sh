#!/usr/bin/env bash

set -e

export dockerImgTag=daominah/go121_lean_example
docker build --tag $dockerImgTag .
docker push $dockerImgTag

set +e
