docker network rm mysql_group
docker network create --subnet=172.19.0.0/24 mysql_group

for N in 1 2 3
do docker run -d \
    --name=node$N --net=mysql_group --hostname=node$N \
    -v $PWD/etc_mysql_conf.d_$N:/etc/mysql/conf.d \
    -v $PWD/d$N:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  mysql:8.0
done
