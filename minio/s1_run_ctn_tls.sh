# this scripts deploy a TLS MinIO server on a remote machine

export DOCKER_IMG_TAG=minio/minio:RELEASE.2020-07-27T18-37-02Z
export dockerCtnName=minio
export hostMountDir=/root/data_minio
export hostMountDir2=/root/data_minio_tls

export machineX=remote0
docker-machine ssh ${machineX} mkdir -p ${hostMountDir2}
docker-machine scp ./example.crt ${machineX}:${hostMountDir2}/public.crt
docker-machine scp ./example.key ${machineX}:${hostMountDir2}/private.key

# prepare and clean up

eval $(docker-machine env ${machineX})

docker pull ${DOCKER_IMG_TAG}
echo "stop and remove old containers"
    docker stop ${dockerCtnName} 2>/dev/null;
    docker rm ${dockerCtnName} 2>/dev/null;

# generate docker run environment file
dkrEnv=${PWD}/env_docker_run.list; bash -x ./env.sh 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}

# docker run on remote machines
source env.sh
echo "published port ${dockerCtnName}: ${MINIO_PORT}"
docker run -dit --restart always --name ${dockerCtnName} \
    --env-file ${dkrEnv} \
    -v ${hostMountDir}:/data \
    -v ${hostMountDir2}:/root/.minio/certs \
    -p ${MINIO_PORT}:${MINIO_PORT} \
    ${DOCKER_IMG_TAG} server /data

eval $(docker-machine env --unset)
