set -x

export SERVER_IDS=(101 102 103)
export HOSTS=()
export GROUP_SEEDS=""
for i in ${!SERVER_IDS[@]}
do
    HOST=172.19.0.${SERVER_IDS[i]}
    export HOSTS+=(${HOST})
    export GROUP_SEEDS+="${HOST}:33061,"
done
export GROUP_SEEDS=${GROUP_SEEDS::-1}

export MY_PASSWORD=123qwe
export DATA_DIR=var_lib_mysql
export CONFIG_DIR_S0=$PWD/step0_init_data_dir
export CONFIG_DIR_S1=$PWD/step1_bootstrap_group
export CONFIG_DIR_S2=$PWD/step2_replication_on_boot
export DOCKER_IMAGE=mysqlgroup
export CTN_NAME=mysqlgroup

set +x

# init MySQL data directory,
# this is a workaround for MySQL ignore plugin_load at initiation

for i in ${!SERVER_IDS[@]}
do
    CONFIG_DIR=${CONFIG_DIR_S0}_${SERVER_IDS[i]}
    mkdir -p $CONFIG_DIR;
    cp $CONFIG_DIR_S0/config-file.cnf $CONFIG_DIR/config-file.cnf
    docker run -d --name=${CTN_NAME}_${SERVER_IDS[i]}_step0 \
         -v $CONFIG_DIR:/etc/mysql/conf.d \
         -v ${DATA_DIR}_${SERVER_IDS[i]}:/var/lib/mysql \
         -e MYSQL_ROOT_PASSWORD=$MY_PASSWORD $DOCKER_IMAGE
done
sleep 3
for i in ${!SERVER_IDS[@]}
do
    docker stop ${CTN_NAME}_${SERVER_IDS[i]}_step0
done

# bootstrap group, should only be done by a single server and only once

export SERVER_ID_S1=${SERVER_IDS[0]} # using in config-file.cnf
export HOST_S1=${HOSTS[0]} # using in config-file.cnf
export CONFIG_DIR_S1_CLONED=${CONFIG_DIR_S1}_${SERVER_ID_S1}
mkdir -p $CONFIG_DIR_S1_CLONED
envsubst < "${CONFIG_DIR_S1}/config-file.cnf" \
    > "${CONFIG_DIR_S1_CLONED}/config-file.cnf"
docker run -d --name=${CTN_NAME}_${SERVER_IDS[0]}_step1 \
    --net=mysql_group --ip=$HOST --hostname=${CTN_NAME}_${SERVER_IDS[0]} \
     -v ${CONFIG_DIR_S1_CLONED}:/etc/mysql/conf.d \
     -v ${DATA_DIR}_${SERVER_IDS[0]}:/var/lib/mysql \
     -e MYSQL_ROOT_PASSWORD=$MY_PASSWORD $DOCKER_IMAGE
docker exec ${CTN_NAME}_${SERVER_IDS[0]}_step1 mysql -uroot -p$MY_PASSWORD -e "SET GLOBAL group_replication_bootstrap_group=ON; START GROUP_REPLICATION; SET GLOBAL group_replication_bootstrap_group=OFF;"
docker stop ${CTN_NAME}_${SERVER_IDS[0]}_step1

# add members to the group

for i in ${!SERVER_IDS[@]}
do
    export HOST=${HOSTS[i]} # using in config-file.cnf
    export SERVER_ID=${SERVER_IDS[i]} # using in config-file.cnf
    CONFIG_DIR=${CONFIG_DIR_S2}_${SERVER_IDS[i]}
    mkdir -p $CONFIG_DIR
    envsubst < "${CONFIG_DIR_S2}/config-file.cnf" \
        > ${CONFIG_DIR}/config-file.cnf

    docker run -d --name=${CTN_NAME}_${SERVER_IDS[i]} \
        --net=mysql_group --ip=$HOST \
        --hostname=${CTN_NAME}_${SERVER_IDS[i]} \
        -v $CONFIG_DIR:/etc/mysql/conf.d -v \
        -v ${DATA_DIR}_${SERVER_IDS[0]}:/var/lib/mysql \
        -e MYSQL_ROOT_PASSWORD=$MY_PASSWORD $DOCKER_IMAGE
done
