# Hello Docker Swarm

## Overview

Steps:
* Create 3 Linux hosts with Docker installed (using Docker Machine)
* Initializing a swarm, adding nodes to the swarm
* Deploying an application to the swarm
* Managing the swarm once you have everything running

## Create 3 Linux hosts with Docker installed

* Install Docker Machine
  * [s1_install_docker_machine.sh](./s1_install_docker_machine.sh)
  * [Install Docker Machine](
    https://docs.docker.com/machine/install-machine/)

* Create machines:
  * [s2_create_machines.sh](./s2_create_machines.sh)
  * [Using an existing host with SSH](
    https://docs.docker.com/machine/drivers/generic)
  * [List all Machine drivers](
    https://docs.docker.com/machine/drivers/)

## Initializing a swarm, adding nodes to the swarm
  
  * [s3_create_swarm.sh](./s3_create_swarm.sh)
  * Show members of the swarm:  
    `docker-machine ssh SwarmManagerWorker0 "docker node ls"`
  * [Create a swarm doc](
    https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/)  
  
## Deploying an application to the swarm

