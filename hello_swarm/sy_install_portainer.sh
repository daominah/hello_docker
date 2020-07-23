docker pull portainer/portainer
docker volume create portainer_data
docker run -d -p 48036:9000 \
    --name=dockerui_portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer

# A docker UI should be available on 127.0.0.1:48036
# Connect to remote docker hosts with ${HOME}/.docker/machine/certs
