docker network create --subnet=172.18.0.0/24 minahbridge

for ZID in 1 2 3;
    do docker run --network minahbridge --ip 172.18.0.20$ZID --name kafka$ZID -dit -e ZID=$ZID kafka;
        docker exec kafka$ZID bash -c "echo $ZID > /var/lib/zookeeper/myid"
        docker exec kafka$ZID sed -i "s/broker.id=/broker.id=$ZID/g" /opt/kafka/config/server.properties
        docker exec kafka$ZID bash -c "echo >> /opt/kafka/config/server.properties"
        docker exec kafka$ZID bash -c "echo advertised.listeners=PLAINTEXT://172.18.0.20$ZID:9092 >> /opt/kafka/config/server.properties"
    done

# go in container
docker exec -it kafka1 bash
docker exec -it kafka2 bash
docker exec -it kafka3 bash

# in container
/usr/share/zookeeper/bin/zkServer.sh start; sleep 1; /usr/share/zookeeper/bin/zkServer.sh status

nohup /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &

# remove containers
for ZID in 1 2 3;
    do docker stop -t 0 kafka$ZID;
        docker rm kafka$ZID;
    done
