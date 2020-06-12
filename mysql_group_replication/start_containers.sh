for N in 11 12 13
do docker run -d \
    --name=node$N --net=mysql_group \
    --hostname=node$N --ip=172.19.0.$N\
    -v $PWD/etc_mysql_conf.d_$N:/etc/mysql/conf.d \
    -v $PWD/var_lib_mysql_$N:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=123qwe \
  mysql:5.7
done
