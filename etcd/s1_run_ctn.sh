export DOCKER_IMG_TAG=daominah/etcd3
dockerCtnName=etcd3
hostMountDir=/root/data_etcd
export MACHINE_NAMES=(local0 local1 local2)

# set shared config fields in cluster
nodeIPs=()
for machine in ${MACHINE_NAMES[@]}; do
    nodeIPs+=($(docker-machine ip ${machine}))
done
echo "machine IPs: ${nodeIPs[@]}"
export etcdNamePrefix=ectd-node-
export ETCD_INITIAL_CLUSTER=""
for i in ${!nodeIPs[@]}; do
    export ETCD_INITIAL_CLUSTER+="${etcdNamePrefix}${i}=http://${nodeIPs[i]}:2380,"
done
export ETCD_INITIAL_CLUSTER=${ETCD_INITIAL_CLUSTER::-1} # remove last delimiter
echo "etcdCluster: ${ETCD_INITIAL_CLUSTER}"

# prepare image
for machine in ${MACHINE_NAMES[@]}; do
    eval $(docker-machine env ${machine})
    docker pull ${DOCKER_IMG_TAG}
    eval $(docker-machine env --unset)
done

# clean up
for machine in ${MACHINE_NAMES[@]}; do
    eval $(docker-machine env ${machine})
    echo "stop and remove old containers"
    docker stop ${dockerCtnName} 2>/dev/null;
    docker rm ${dockerCtnName} 2>/dev/null;
    eval $(docker-machine env --unset)
done

# docker run on remote machines
set -e

for i in ${!MACHINE_NAMES[@]}; do
    eval $(docker-machine env ${MACHINE_NAMES[i]})

    # prepare specific node config, will be used in env.sh
    export ETCD_NAME=${etcdNamePrefix}${i}
    export ETCD_INITIAL_ADVERTISE_PEER_URLS=http://${nodeIPs[i]}:2380

    # generate docker run environment file
    realConfigFile=./env.sh
    dkrEnv=${PWD}/env_docker_run.list; bash -x ${realConfigFile} 2>${dkrEnv}
    sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}

    # should add --restart always in production
    docker run -dit --name=${dockerCtnName} \
        -v ${hostMountDir}:/etcd-data \
        -p 2379:2379 -p 2380:2380 \
        --env-file=${dkrEnv} \
        ${DOCKER_IMG_TAG}

    eval $(docker-machine env --unset)
done
