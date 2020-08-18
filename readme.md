# Hello Docker

## Useful commands

### Copy docker image to machines

Instead of pull, copy is faster for local testing.

````bash
DOCKER_IMG_TAG=daominah/etcd3
imageFile=tmp.img
docker save -o ${imageFile} ${DOCKER_IMG_TAG}
for i in 0 1 2; do
    docker-machine scp ./${imageFile} local$i:/home/docker/${imageFile}
    docker-machine ssh local$i "docker load -i /home/docker/${imageFile}"
done
````

### Generate docker run environment file

````bash
realConfigFile=conf/env.sh
dkrEnv=${PWD}/env_docker_run.list; bash -x ${realConfigFile} 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}
````
