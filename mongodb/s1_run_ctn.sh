# need to config before run

export DOCKER_IMG_TAG=daominah/mongo4 # defined in s0_
dockerCtnName=mongo4
hostMountDir=/home/tungdt/var/data_mongo # dir on remote docker host

export MACHINE_NAME=local

#_______________________________________________________________________________

# prepare and clean up
machine0="${MACHINE_NAME}0"
#eval $(docker-machine env ${machine0}) # uncomment to deploy on remote host

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

# docker run on remote machines
docker run -dit --name=${dockerCtnName} \
     -v ${hostMountDir}:/var/lib/mysql \
     -p 27017:27017 \
     --env-file ${dockerRunEnvList} \
     ${DOCKER_IMG_TAG}

#eval $(docker-machine env --unset)
