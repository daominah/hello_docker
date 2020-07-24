set -x

docker stop mongodb4
docker rm mongodb4
sudo rm -rf ${PWD}/data_db

set +x
