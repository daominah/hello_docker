export DOCKER_IMG_TAG=daominah/python39
docker build --tag=${DOCKER_IMG_TAG} .
docker push ${DOCKER_IMG_TAG}
