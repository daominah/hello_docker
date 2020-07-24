dockerRunEnvList=${PWD}/docker_run_env.list
bash -x env.sh 2>${dockerRunEnvList}  # stderr to the file
sed -i '/^+ export /d' ${dockerRunEnvList}
sed -i 's/+ //' ${dockerRunEnvList}

source env.sh

docker run -dit --name=mysql8 \
     --volume ${DATA_DIR}:/var/lib/mysql \
     --network=host \
     --env MYSQL_ROOT_PASSWORD=${MY_PASSWORD} \
     --env-file ${dockerRunEnvList} \
     daominah/mysql8
