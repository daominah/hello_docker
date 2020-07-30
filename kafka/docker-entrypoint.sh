#!/bin/bash

printenv # for debugging

# config zookeeper
echo "about to run default entrypoint from base Zookeeper image: $@"
. /docker-entrypoint_zoo.sh "$@"

# config kafka
echo "config kafka"
envsubst < "/kafka_server.properties.tpl" > "/opt/kafka/config/server.properties"

exec "$@"
