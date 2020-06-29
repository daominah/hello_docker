export SERVER_IDS=(101 102 103)
export NAME_PRE=mysqlGroup

for SERVER_ID in ${SERVER_IDS[@]}
do
    docker stop -t 1 $NAME_PRE$SERVER_ID
    docker rm $NAME_PRE$SERVER_ID
    rm -rf etc_mysql_conf.d_$SERVER_ID
    sudo rm -rf var_lib_mysql_$SERVER_ID
done
