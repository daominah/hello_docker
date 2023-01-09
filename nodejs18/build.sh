#!/usr/bin/env bash

export DockerImgTag=daominah/nodejs18

docker build --tag=${DockerImgTag} .
