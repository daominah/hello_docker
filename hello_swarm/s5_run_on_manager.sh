export appVersion=0.1.0
docker service create --replicas 3 --name example_app \
    --publish published=20891,target=20891 \
    daominah/example_app:${appVersion}
