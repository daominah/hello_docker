set -x

export manager0=dosmanager0

docker-machine ls
docker-machine ssh ${manager0} "docker service ps example_app"

set +x
