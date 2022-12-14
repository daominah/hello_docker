set -e  # exit on error

export DOCKER_IMG_TAG=daominah/etcd35 # used in s1_

(cd image && docker build --tag=${DOCKER_IMG_TAG} .)

# default to hub.docker.com. should be changed to a private registry
docker push ${DOCKER_IMG_TAG}
