#!/usr/bin/env bash

dockerCtnName=go121_lean_example
docker rm -f ${dockerCtnName} 2>/dev/null
docker run -dit --name ${dockerCtnName} -p 8888:8888 daominah/go121_lean_example

# to test the server, run from the docker host:
# curl -i -X POST 'http://127.0.0.1:8888/deposit' --data '{"username":"user0", "amount":1000}'
# curl -i 'http://127.0.0.1:8888/user/user0'
