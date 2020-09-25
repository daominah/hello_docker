# Setup an etcd cluster


## Dockerfile

Dockerfile is based on installing script on [https://github.com/etcd-io/etcd/releases].

Configuration for running containers:

* [https://github.com/etcd-io/etcd]
* [https://etcd.io/docs/v3.4.0/op-guide/clustering]
* [https://etcd.io/docs/v3.4.0/op-guide/authentication]


## Run a stand-alone server

````bash
docker run -dit --name=etcd3 -p 2379:2379 -p 2380:2380 daominah/etcd3
````

## Run client etcdctl

````bash
docker run -it --rm --network=host daominah/etcd3 \
    /opt/etcd/etcdctl --endpoints=http://127.0.0.1:2379 put key0 val0
````

## Run a cluster

Use script [./s1_run_ctn.sh](./s1_run_ctn.sh).

Full doc [envs config](https://etcd.io/docs/v3.4.0/op-guide/configuration/)

## Basic usages

* [docs/v3.4.0/dev-guide](https://etcd.io/docs/v3.4.0/dev-guide/interacting_v3/)
* Get cluster status:

````bash
etcdctl -w table --command-timeout=1s \
    --endpoints=192.168.99.100:2379,192.168.99.101:2379,192.168.99.102:2379 \
    endpoint status

etcdctl member list; etcdctl member list -w fields
````

* [Replace a failed machine](https://github.com/etcd-io/etcd/blob/61354ff8ede7dde7839e0df987f37cda931fd740/Documentation/op-guide/runtime-configuration.md#replace-a-failed-machine):

If a machine fails due to hardware failure, data directory corruption,
we need to replace (remove and add) the fail member.

````bash
etcdctl member list # to know failed member info
FAILED_ETCD_ID=305750b374006637
FAILED_ETCD_NAME=ectd-node-2
FAILED__ETCD_INITIAL_ADVERTISE_PEER_URLS=http://192.168.99.102:2380

etcdctl member remove ${FAILED_ETCD_ID}

etcdctl member add ${FAILED_ETCD_NAME} --peer-urls ${FAILED__ETCD_INITIAL_ADVERTISE_PEER_URLS}
````

## GUI client

TODO
