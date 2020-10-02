DOCKER_IMG_TAG=daominah/chrome_shell
dockerCtnName=chrome_shell

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
docker run -dit --name ${dockerCtnName} \
    --env-file ${dockerRunEnvList} \
    --network=host \
    --init ${DOCKER_IMG_TAG}
