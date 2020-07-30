# init a swarm of all nodes

set -x

export nodes=(128.199.73.81 188.166.250.8 188.166.246.39) # same var s2
export hostName=dosmanager # same var s2, s5

export hostNames=()
for i in ${!nodes[@]}
do
    export hostNames+=("${hostName}${i}")
done

#
# init the swarm on nodes0
#

docker-machine ssh ${hostNames[0]} \
    "docker swarm init --listen-addr $(docker-machine ip ${hostNames[0]}) \\
        --advertise-addr $(docker-machine ip ${hostNames[0]})"

export managerToken=$(docker-machine ssh ${hostNames[0]} \
    "docker swarm join-token manager -q")
export workerToken=$(docker-machine ssh ${hostNames[0]} \
    "docker swarm join-token worker -q")

#
# other managers join the swarm,
# by default, managers are workers too,
#

for i in ${!hostNames[@]}
do
if ((i != 0)); then
	echo "${hostNames[i]} joining swarm as manager"
	docker-machine ssh ${hostNames[i]} \
		"docker swarm join --token $managerToken \
		--listen-addr $(docker-machine ip ${hostNames[i]}) \
		--advertise-addr $(docker-machine ip ${hostNames[i]}) \
		$(docker-machine ip ${hostNames[0]})"
fi
done

# show members of swarm
docker-machine ssh ${hostNames[0]} "docker node ls"

set +x
