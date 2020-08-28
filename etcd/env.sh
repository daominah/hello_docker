# https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/configuration.md

# defined in s1, human-readable name for a member
export ETCD_NAME=${ETCD_NAME}

# data dir in container, should be mount
export ETCD_DATA_DIR=/etcd-data

# accept incoming client's request on the specified scheme://IP:port,
# domain name is invalid
export ETCD_LISTEN_CLIENT_URLS=http://0.0.0.0:2379
export ETCD_ADVERTISE_CLIENT_URLS=${ETCD_LISTEN_CLIENT_URLS}

# addr for communicating in cluster
export ETCD_LISTEN_PEER_URLS=http://0.0.0.0:2380
export ETCD_INITIAL_ADVERTISE_PEER_URLS=${ETCD_INITIAL_ADVERTISE_PEER_URLS}
# ex: ectd-node-0=http://192.168.99.100:2380,ectd-node-1=http://192.168.99.101:2380
export ETCD_INITIAL_CLUSTER=${ETCD_INITIAL_CLUSTER}

# for etcdctl auth enable
export ETCD_ROOT_PASSWORD=

# https://etcd.io/docs/v3.4.0/op-guide/maintenance/
export ETCD_AUTO_COMPACTION_RETENTION=1
export ETCD_QUOTA_BACKEND_BYTES=8589934592
