export machine=local

export dockerImgTag=daominah/mysql8
export dockerCtnName=mysql8
export hostMountDir=$HOME/var/data_mysql
export MYSQL_PORT=3306 # same value as env.sh


# clean up old container
echo "stop and remove old container ${dockerCtnName} in ${machine}"
docker stop -t 2 ${dockerCtnName} 2>/dev/null;
docker rm ${dockerCtnName} 2>/dev/null;


echo "preparing envs"
dkrEnv=${PWD}/env_docker_run.list0; bash -x ./env.sh 2>${dkrEnv}
sed -i 's/+ //' ${dkrEnv}; sed -i '/^export /d' ${dkrEnv}; sed -i "s/'//g" ${dkrEnv}

docker run -dit --name=${dockerCtnName} --restart always \
    -v ${hostMountDir}:/var/lib/mysql \
    -p ${MYSQL_PORT}:${MYSQL_PORT} \
    --env-file ${dkrEnv} \
    ${dockerImgTag}

# wait for mysqld to be ready
until /bin/nc -z -v -w30 127.0.0.1 ${MYSQL_PORT}
do
    echo "wait for mysqld to be ready"
    sleep 1
done
sleep 1

echo "done init MySQL data"
