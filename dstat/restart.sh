#!/usr/bin/env bash
for ctn in $(docker ps --format '{{.Names}}'); do
    docker restart -t 0 $ctn;
done
