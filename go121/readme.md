````bash
docker build --tag=daominah/go116 .

docker push daominah/go116

docker run --network host --restart=no --name go116 -dit daominah/go116

docker exec -it go116 bash
````
