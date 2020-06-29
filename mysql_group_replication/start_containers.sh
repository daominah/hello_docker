set -x

export SERVER_IDS=(101 102 103)
export NAME_PRE=mysqlGroup

export HOSTS=()
for ID in ${SERVER_IDS[@]}
    do export HOSTS+=(172.19.0.$ID)
done
export GROUP_SEED="${HOSTS[0]}:33061"

export DOCKER_IMAGE=mysqlgroup

# init first time
for i in ${!SERVER_IDS[@]}
do
    CONFIG_DIR=$PWD/first_time_etc_mysql_conf.d_${SERVER_IDS[i]}
    DATA_DIR=$PWD/var_lib_mysql_${SERVER_IDS[i]}
    mkdir -p $CONFIG_DIR
    docker run -d --name=$NAME_PRE${SERVER_IDS[i]}_tmp \
         -v $CONFIG_DIR:/etc/mysql/conf.d -v $DATA_DIR:/var/lib/mysql \
         -e MYSQL_ROOT_PASSWORD=123qwe \
         $DOCKER_IMAGE
done
sleep 3
for i in ${!SERVER_IDS[@]}; do docker stop $NAME_PRE${SERVER_IDS[i]}_tmp; done

# init group
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
         $DOCKER_IMAGE
    # Warning: Creating a group and joining multiple members
    # at the same time is not supported
    sleep 2
done
