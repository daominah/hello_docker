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
* Cluster status:

  ````bash
  etcdctl -w table --command-timeout=1s \
      --endpoints=192.168.99.100:2379,192.168.99.101:2379,192.168.99.102:2379 \
      endpoint status
  ````

## GUI client

TODO
