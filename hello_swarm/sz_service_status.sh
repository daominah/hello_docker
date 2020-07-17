set -x

docker-machine ls
docker-machine ssh SwarmManagerWorker0 "docker service ps example_app"

set +x
