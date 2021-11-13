dockerCtnName=go116
docker stop ${dockerCtnName} 2>/dev/null;
docker rm ${dockerCtnName} 2>/dev/null;
docker run --network host --restart=no --name ${dockerCtnName} -dit daominah/go116
