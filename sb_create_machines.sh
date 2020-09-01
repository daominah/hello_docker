isRemote=false

set -x
if ${isRemote}; then # create machines on remote nodes
    nodeIPs=(128.199.73.81 188.166.250.8 188.166.246.39) # some example IPs
    sshKey="${HOME}/.ssh/id_rsa"
    machineName=myRemoteDocker
    for i in ${!nodeIPs[@]}
    do
        docker-machine --debug --native-ssh create --driver generic \
            --generic-ip-address=${nodeIPs[i]} \
            --generic-ssh-key ${sshKey} \
            ${machineName}${i}
        # in case: error certificate signed by unknown authority:
        # docker-machine --debug regenerate-certs -f machineName
    done
else # create machines on local virtual
    machineName=local
    for i in 0 1 2; do
        docker-machine create --driver virtualbox --virtualbox-memory 1536 \
            ${machineName}${i}
    done
    # print IP addresss of local machines
    for i in 0 1 2; do
        docker-machine ip ${machineName}${i}
    done
fi

set +x
