dockerRunEnvList=${PWD}/docker_run_env.list
rm ${dockerRunEnvList} 2>/dev/null; cp ${PWD}/env.sh ${dockerRunEnvList}
sed -i 's/export //' ${dockerRunEnvList}

docker run -dit --name kafka \
    -p 2181:2181 -p 2888:2888 -p 3888:3888 \
    --env-file ${dockerRunEnvList} \
    daominah/kafka
