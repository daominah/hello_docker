# run this sh on a manager node

export appVersion=0.1.0

# docker point to manager0
eval $(docker-machine env dosmanager0)

# default swarm's balancer https://docs.docker.com/engine/swarm/ingress,
# beware performance, found some issues on github,
docker service create --replicas 3 --name example_app \
    --publish published=20891,target=20891 \
    daominah/example_app:${appVersion}

# disable default balancer:
#docker service create --replicas 3 --name example_app \
#    --network host \
#    daominah/example_app:${appVersion}

# docker point back to local
eval $(docker-machine env --unset)
