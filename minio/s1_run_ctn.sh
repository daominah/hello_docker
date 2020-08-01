DOCKER_IMG_TAG=minio/minio:RELEASE.2020-07-27T18-37-02Z
dockerCtnName=minio
hostMountDir=${HOME}/var/miniodata

docker pull ${DOCKER_IMG_TAG}

echo "stop and remove old containers"
    docker stop ${dockerCtnName} 2>/dev/null;
    docker rm ${dockerCtnName} 2>/dev/null;

# generate docker run environment file
dockerRunEnvList=${PWD}/env_docker_run.list
bash -x env.sh 2>${dockerRunEnvList}
sed -i 's/+ //' ${dockerRunEnvList}
sed -i '/^export /d' ${dockerRunEnvList}
sed -i "s/'//g" ${dockerRunEnvList}

source env.sh
echo "published port ${dockerCtnName}: ${MINIO_PORT}"
mkdir -p ${hostMountDir}
docker run -dit --name ${dockerCtnName} \
    --env-file ${dockerRunEnvList} \
    -p ${MINIO_PORT}:${MINIO_PORT} \
    ${DOCKER_IMG_TAG} server ${hostMountDir}
