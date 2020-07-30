# install docker on cluster's nodes

set -x

export nodes=(128.199.73.81 188.166.250.8 188.166.246.39) # same var s3
export sshKey="${HOME}/.ssh/id_rsa"
export hostName=dosmanager # same var s3, s5

for i in ${!nodes[@]}
do
    docker-machine --debug --native-ssh create --driver generic \
        --generic-ip-address=${nodes[i]} \
        --generic-ssh-key ${sshKey} \
        ${hostName}${i}
done

set +x

#
# in case: error certificate signed by unknown authority
# docker-machine --debug regenerate-certs -f SwarmManagerWorker2
#
