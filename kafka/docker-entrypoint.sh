#!/bin/bash

set -x

echo "about to run default entrypoint from base Zookeeper image: $@"
. /docker-entrypoint_origin.sh "$@"

set +x
