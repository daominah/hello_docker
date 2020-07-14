set -x

export nodes=(167.71.223.57 167.71.223.120 167.71.213.123)
export ssh_key="${HOME}/.ssh/id_rsa"

for i in ${!nodes[@]}
do
    docker-machine --debug --native-ssh create --driver generic \
        --generic-ip-address=${nodes[i]} \
        --generic-ssh-key ${ssh_key} \
        SwarmManagerWorker${i}
done

set +x
