isRemote=false

set -x

# create machines on remote nodes
if ${isRemote}; then
    export nodeIPs=(192.168.0.2 192.168.0.3)
    export sshKey="${HOME}/.ssh/id_rsa"
    export MACHINE_PREFIX=remote # used in */s1_run
    export dockerVersion=5:19.03.15~3-0~ubuntu-bionic

    for i in ${!nodeIPs[@]}
    do
        if ((i == 1)); then # select machine
            docker-machine --debug --native-ssh create --driver generic \
                --generic-ip-address=${nodeIPs[i]} \
                --generic-ssh-port=22 \
                --generic-ssh-user=root \
                --generic-ssh-key ${sshKey} \
                ${MACHINE_PREFIX}${i}

            # change docker version
            docker-machine ssh ${MACHINE_PREFIX}${i} \
                sudo apt install -y --allow-downgrades docker-ce=${dockerVersion}
            docker-machine ssh ${MACHINE_PREFIX}${i} \
                sudo systemctl restart docker
            # optional, allow run docker as a non root user
            docker-machine ssh ${MACHINE_PREFIX}${i} \
                'sudo usermod -aG docker ${USER}'
        fi
    done

# create machines on local virtual
else
    machineName=local
    for i in 0 1 2; do
        docker-machine create --driver virtualbox \
            --virtualbox-memory 1536 \
            ${machineName}${i}
    done
    # print IP addresss of local machines
    for i in 0 1 2; do
        docker-machine ip ${machineName}${i}
    done
fi

set +x
