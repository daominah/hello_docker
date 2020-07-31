set -x

docker stop mysql8
docker rm mysql8
sudo rm -rf ${PWD}/var_lib_mysql

set +x
