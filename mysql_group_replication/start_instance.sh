set -x

export SERVER_IDS=(11 22)
export THIS_COMPUTER=11
export HOSTS=()
export GROUP_SEEDS=""
for i in ${!SERVER_IDS[@]}
do
    HOST=172.16.121.${SERVER_IDS[i]}
    export HOSTS+=(${HOST})
    export GROUP_SEEDS+="${HOST}:33061,"
done
export GROUP_SEEDS=${GROUP_SEEDS::-1}
export GROUP_NAME="9d2ae0e0-1451-4971-86fb-451baa9f2dc7"

export ROOT_PW=123qwe
export RPL_USER=rpl_user
export RPL_USER_H="${RPL_USER}@'%'"
export RPL_PW=123qwe
export DATA_DIR=$PWD/var_lib_mysql
export CONFIG_DIR_S0=$PWD/step0_init_data_dir
export CONFIG_DIR_S1=$PWD/step1_bootstrap_group
export CONFIG_DIR_S2=$PWD/step2_replication_on_boot
export DOCKER_IMAGE=mysqlgroup
export CTN_NAME=mysqlgroup
export NETWORK_NAME=host

#set +x

#
# init MySQL data directory, this is a workaround for MySQL ignore
# plugin_load at initiation
#

for i in ${!SERVER_IDS[@]}
do
if ((SERVER_IDS[i]==${THIS_COMPUTER})); then
    CONFIG_DIR=${CONFIG_DIR_S0}_${SERVER_IDS[i]}
    mkdir -p $CONFIG_DIR;
    cp $CONFIG_DIR_S0/config-file.cnf $CONFIG_DIR/config-file.cnf
    docker run -d --name=${CTN_NAME}_${SERVER_IDS[i]}_step0 \
         -v $CONFIG_DIR:/etc/mysql/conf.d \
         -v ${DATA_DIR}_${SERVER_IDS[i]}:/var/lib/mysql \
         -e MYSQL_ROOT_PASSWORD=$ROOT_PW $DOCKER_IMAGE
fi
done
sleep 3
docker stop ${CTN_NAME}_${THIS_COMPUTER}_step0

#
# bootstrap group should only be done by a single server and only once
#

for i in ${!SERVER_IDS[@]}
do
if ((SERVER_IDS[i]==${THIS_COMPUTER})); then
    export SERVER_ID=${SERVER_IDS[i]} # config-file.cnf
    export HOST=${HOSTS[i]} # config-file.cnf
    export CONFIG_DIR_S1_CLONED=${CONFIG_DIR_S1}_${SERVER_ID}
    mkdir -p $CONFIG_DIR_S1_CLONED
    envsubst < "${CONFIG_DIR_S1}/config-file.cnf" \
        > "${CONFIG_DIR_S1_CLONED}/config-file.cnf"
    docker run -d --name=${CTN_NAME}_${SERVER_IDS[i]} \
        --net=${NETWORK_NAME} \
        --hostname=${HOSTS[i]} \
        -v ${CONFIG_DIR_S1_CLONED}:/etc/mysql/conf.d \
        -v ${DATA_DIR}_${SERVER_IDS[i]}:/var/lib/mysql \
        -e MYSQL_ROOT_PASSWORD=$ROOT_PW $DOCKER_IMAGE
    sleep 5

    q0="SET SQL_LOG_BIN=0;"
    q0+="CREATE USER ${RPL_USER_H} IDENTIFIED BY '${RPL_PW}';"
    q0+="GRANT REPLICATION SLAVE ON *.* TO ${RPL_USER_H};"
    q0+="GRANT BACKUP_ADMIN ON *.* TO ${RPL_USER_H};"
    q0+="FLUSH PRIVILEGES;"
    q0+="SET SQL_LOG_BIN=1;"
    q0+="CHANGE MASTER TO MASTER_USER='$RPL_USER',  MASTER_PASSWORD='${RPL_PW}' FOR CHANNEL 'group_replication_recovery';"
    docker exec ${CTN_NAME}_${SERVER_IDS[i]} \
        mysql -uroot -p$ROOT_PW -e "$q0"

    if ((i == 0)); then
        q1="SET GLOBAL group_replication_bootstrap_group=ON;"
        q1+="START GROUP_REPLICATION;"
        q1+="SET GLOBAL group_replication_bootstrap_group=OFF;"
        docker exec ${CTN_NAME}_${SERVER_IDS[i]} \
            mysql -uroot -p$ROOT_PW -e "$q1"
    else
        docker exec ${CTN_NAME}_${SERVER_IDS[i]} \
            mysql -uroot -p$ROOT_PW -e "START GROUP_REPLICATION"
    fi
    sleep 1
fi
done

#
# edit config group_replication_start_on_boot
#
#for i in ${!SERVER_IDS[@]}
#do
#    echo "TODO"
#done

set +x
