for N in 11 12 13
do
    docker stop -t 0 node$N
    docker rm node$N
    sudo rm -rf ./var_lib_mysql_$N
done
