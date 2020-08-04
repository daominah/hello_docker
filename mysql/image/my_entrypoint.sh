#!/usr/bin/env bash

set -e

# `/entrypoint.sh` is from mysql official image:
# https://github.com/docker-library/mysql/blob/master/8.0/docker-entrypoint.sh

echo "generate mysqld config file from env"
envsubst < "/config-file.cnf_tpl" > "/etc/mysql/conf.d/config-file.cnf"

echo "about to run default entrypoint from base MySQL image: $@"
. /entrypoint.sh "$@"
_main "$@"
