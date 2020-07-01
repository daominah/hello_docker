export SERVER_IDS=(101 102 103)
export CTN_NAME=mysqlgroup

set -x

for i in ${!SERVER_IDS[@]}
do
    docker rm ${CTN_NAME}_${SERVER_IDS[i]}_step0
    docker stop -t 0 ${CTN_NAME}_${SERVER_IDS[i]}
    docker rm ${CTN_NAME}_${SERVER_IDS[i]}
    rm -rf $PWD/step0_init_data_dir_${SERVER_IDS[i]}
    rm -rf $PWD/step1_bootstrap_group_${SERVER_IDS[i]}
    sudo rm -rf $PWD/var_lib_mysql_${SERVER_IDS[i]}
done

set +x
