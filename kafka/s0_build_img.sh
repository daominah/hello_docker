export DOCKER_IMG_TAG=daominah/kafka # same var in s1

docker build --tag=${DOCKER_IMG_TAG} .

# default to hub.docker.com. should be private
docker push ${DOCKER_IMG_TAG}
