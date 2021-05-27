#!/usr/bin/env bash

set -e


if [[ "${MYSQL_IS_GROUP_REPLICATION^^}" == "" ]]; then
    echo "generate mysqld config file from cnf_normal_tpl"
    envsubst < "/config-file.cnf_normal_tpl" > "/etc/mysql/conf.d/config-file.cnf"
else
    if [[ -e /is_2nd_boot ]]; then
        echo "generate mysqld config file from cnf_rep_group_tpl (2nd boot)"
        export MYSQL_GROUP_REPLICATION_START_ON_BOOT=ON
    else
        echo "generate mysqld config file from cnf_rep_group_tpl (1st boot)"
    fi
    envsubst < "/config-file.cnf_rep_group_tpl" > "/etc/mysql/conf.d/config-file.cnf"
fi
echo "cat /etc/mysql/conf.d/config-file.cnf:"
cat /etc/mysql/conf.d/config-file.cnf


# https://github.com/docker-library/mysql/blob/master/8.0/docker-entrypoint.sh
# the following `/entrypoint.sh` is from mysql official image
echo "about to run default entrypoint from base MySQL image: $@"
. /entrypoint.sh "$@"
_main "$@"
