# only run this script while testing

export MACHINE_NAMES=(local0 local1 local2)
dockerCtnName=etcd3
for machine in ${MACHINE_NAMES[@]}; do
    eval $(docker-machine env ${machine})
    echo "remove running containers and data dir on ${machine}"
    docker rm -f ${dockerCtnName} 2>/dev/null;
    eval $(docker-machine env --unset)
    docker-machine ssh ${machine} "sudo rm -rf /root/data_etcd"
done
