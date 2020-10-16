DOCKER_IMG_TAG=daominah/chrome_shell
dockerCtnName=chrome_shell

docker pull ${DOCKER_IMG_TAG}

echo "stop and remove old containers"
docker stop ${dockerCtnName} 2>/dev/null;
docker rm ${dockerCtnName} 2>/dev/null;

# generate docker run environment file
dkrEnv=${PWD}/env_docker_run.list; bash -x ./env.sh 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}

source env.sh
docker run -dit --name ${dockerCtnName} \
    --env-file ${dkrEnv} \
    --network=host \
    --init ${DOCKER_IMG_TAG}
