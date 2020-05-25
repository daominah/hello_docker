# The base OS
FROM ubuntu:18.04

MAINTAINER TungDT <tung.daothanhtung@gmail.com>

RUN apt-get update
RUN apt-get install --quiet --yes net-tools wget vim

RUN apt-get install -yq default-jre
RUN apt-get install -yq zookeeper

RUN wget -q http://mirrors.viethosting.com/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz
RUN tar -xzf kafka_2.12-2.3.0.tgz -C /opt &&\
    mv /opt/kafka_2.12-2.3.0 /opt/kafka &&\
    rm kafka_2.12-2.3.0.tgz

ENV HOST_IDS="1 2 3"
ENV HOST_IP_PREFIX="172.18.0.20"

RUN for i in $HOST_IDS; \
    do echo server.$i=$HOST_IP_PREFIX$i:2888:3888 >> /etc/zookeeper/conf/zoo.cfg; \
    done

RUN export BROKER_LIST="" &&\
    for i in $HOST_IDS; \
        do BROKER_LIST="$BROKER_LIST$HOST_IP_PREFIX$i:2181,"; \
        done &&\
    BROKER_LIST=$(echo -n $BROKER_LIST | head -c -1) &&\
    sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$BROKER_LIST/g" /opt/kafka/config/server.properties
