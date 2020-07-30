machines=(local0 local1 local2)
nodeIDs=(1 2 3)
export DOCKER_IMG_TAG=daominah/kafka # same var in s0
dockerCtnName=kafka
dockerRunEnvSh=${PWD}/env.sh

# deploy on all nodes
nodeIPs=()
for m in ${machines[@]}; do
    nodeIPs+=($(docker-machine ip ${m}))
done
for i in ${!nodeIDs[@]}; do
    # prepare specific node config
    export ZOO_MY_ID=${nodeIDs[i]} # used in env.sh
    export ZOO_SERVERS="" # used in env.sh
    for k in ${!nodeIPs[@]}; do
        if ((i == k)); then
            export ZOO_SERVERS+="server.${ZOO_MY_ID}=0.0.0.0:2888:3888;2181 "
        else
            export ZOO_SERVERS+="server.${nodeIDs[k]}=${nodeIPs[k]}:2888:3888;2181 "
        fi
    done
    export ZOO_SERVERS=${ZOO_SERVERS::-1} # remove last character

    export KAFKA_BROKER_ID=${nodeIDs[i]}${nodeIDs[i]}
    export KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://${nodeIPs[i]}:9092

    dockerRunEnvList=${PWD}/env_docker_run.list
    bash -x ${dockerRunEnvSh} 2>${dockerRunEnvList}
    sed -i 's/+ //' ${dockerRunEnvList}
    sed -i '/^export /d' ${dockerRunEnvList}
    sed -i "s/'//g" ${dockerRunEnvList}

    # pull image and run container image on remote host
    eval $(docker-machine env ${machines[i]})
    docker stop ${dockerCtnName} 2>/dev/null;
    docker rm ${dockerCtnName} 2>/dev/null;
    docker pull ${DOCKER_IMG_TAG}
    docker run -dit --name ${dockerCtnName} \
        -p 2181:2181 -p 2888:2888 -p 3888:3888 -p 9092:9092 \
        --env-file ${dockerRunEnvList} \
        ${DOCKER_IMG_TAG}
    eval $(docker-machine env --unset)
done
