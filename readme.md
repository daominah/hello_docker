# Hello Docker

## Common structure

Each sub directory includes scripts to setup a tech. They follow a
common structure:

* `image/Dockerfile`: optional, customize image for easy config from 
  environment variable (example: [./mysql/image/Dockerfile])
* `env.sh`: environment variables for `docker run`
* `s0_build_img.sh`
* `s1_run_ctn.sh`: customize env for each nodes in cluster, run 
  containers on remote nodes with docker-machine from local computer.

## Useful commands

### Install docker-machine, create 3 virtual machines

* [./sa_local_prepare.sh]
* [./sb_create_machines.sh]

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
dkrEnv=${PWD}/env_docker_run.list; bash -x ./env.sh 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}
````
