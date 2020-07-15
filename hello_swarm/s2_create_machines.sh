# install docker on cluster's nodes

set -x

export nodes=(167.71.223.57 167.71.223.120 167.71.213.123) # same var s3
export sshKey="${HOME}/.ssh/id_rsa"
export hostName=SwarmManagerWorker # same var s3

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
