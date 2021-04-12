# this scripts deploy a MinIO server on the local machine

export DOCKER_IMG_TAG=minio/minio:RELEASE.2020-07-27T18-37-02Z
export dockerCtnName=minio
export hostMountDir=/home/tungdt/var/data_minio

docker pull ${DOCKER_IMG_TAG}

echo "stop and remove old containers"
    docker stop ${dockerCtnName} 2>/dev/null;
    docker rm ${dockerCtnName} 2>/dev/null;

# generate docker run environment file
dkrEnv=${PWD}/env_docker_run.list; bash -x ./env.sh 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}

source env.sh
echo "published port ${dockerCtnName}: ${MINIO_PORT}"
mkdir -p ${hostMountDir}
docker run -dit --name ${dockerCtnName} \
    --env-file ${dkrEnv} \
    -v ${hostMountDir}:/data \
    -p ${MINIO_PORT}:${MINIO_PORT} \
    ${DOCKER_IMG_TAG} server /data
