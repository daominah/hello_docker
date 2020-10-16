# need to config before run

export DOCKER_IMG_TAG=daominah/mysql8 # defined in s0_
dockerCtnName=mysql8
hostMountDir=/home/tungdt/var/data_mysql # dir on remote docker host

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
dkrEnv=${PWD}/env_docker_run.list; bash -x ./env.sh 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}

# docker run on remote machines
source env.sh
echo "published port ${dockerCtnName}: ${MYSQL_PORT}"
docker run -dit --name=${dockerCtnName} \
     -v ${hostMountDir}:/var/lib/mysql \
     -p ${MYSQL_PORT}:${MYSQL_PORT} -p 33060:33060 -p 33061:33061 \
     --env-file ${dkrEnv} \
     ${DOCKER_IMG_TAG}

#eval $(docker-machine env --unset)
