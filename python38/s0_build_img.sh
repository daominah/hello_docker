export DOCKER_IMG_TAG=daominah/python38
docker build --tag=${DOCKER_IMG_TAG} .
docker push ${DOCKER_IMG_TAG}
