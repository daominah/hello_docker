export SERVER_IDS=(101 102 103)
export NAME_PRE=mysqlGroup

export HOSTS=()
for ID in ${SERVER_IDS[@]}
    do export HOSTS+=(172.19.0.$ID)
done
export GROUP_SEED="${HOSTS[0]}:33061"


for i in ${!SERVER_IDS[@]}
do
    export SERVER_ID=${SERVER_IDS[i]}
    export HOST=${HOSTS[i]}
    CONFIG_DIR=$PWD/etc_mysql_conf.d_$SERVER_ID
    DATA_DIR=$PWD/var_lib_mysql_$SERVER_ID
    mkdir -p $CONFIG_DIR
    envsubst < "./etc_mysql_conf.d/config-file.cnf" \
        > $CONFIG_DIR/config-file.cnf

    docker run -d --name=$NAME_PRE$SERVER_ID --net=mysql_group --ip=$HOST \
         -v $CONFIG_DIR:/etc/mysql/conf.d -v $DATA_DIR:/var/lib/mysql \
         -e MYSQL_ROOT_PASSWORD=123qwe \
         mysql:8.0.20
    # Warning: Creating a group and joining multiple members
    # at the same time is not supported
    sleep 2
done
