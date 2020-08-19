#!/usr/bin/env bash

if [[ $(stat -c "%a" "$ETCD_DATA_DIR") != *700 ]]; then
    echo "setting data dir perm to 700 (required in etcd >=3.4.10)"
    chmod -R 700 "$ETCD_DATA_DIR"
fi

(
    sleep $(( 5 + $RANDOM % 5))
    etcdUsers=$(etcdctl user list 2>&1)
    if [ -z "${etcdUsers}" ]; then
        echo "$(date --iso=ns): user list is empty, will create user root"
        echo "$ETCD_ROOT_PASSWORD" | etcdctl user add root --interactive=false
        etcdctl user grant-role root root
        etcdctl auth enable
        echo "$(date --iso=ns): done etcdctl auth enable"
    else
        echo "$(date --iso=ns): return of user list: ${etcdUsers}"
    fi
) &

exec "$@"
