FROM zookeeper:3.5.7
# Debian GNU/Linux 10 (buster)

# change to Vietnam mirror, main mirror is so slow
RUN sed -i -e 's/deb.debian.org/debian.xtdv.net/g' /etc/apt/sources.list
RUN apt-get update

# kafka:2.5.0, released 2020-04-15, prefer Zookeeper to 3.5.7
ENV kafkaVer 2.5.0
ENV scalaVer 2.12
ENV kafkaHome /opt/kafka_${scalaVer}-${kafkaVer}
ENV kafkaMirror http://mirrors.viethosting.com/apache/kafka
RUN wget -q ${kafkaMirror}/${kafkaVer}/kafka_${scalaVer}-${kafkaVer}.tgz
RUN tar -xzf kafka_${scalaVer}-${kafkaVer}.tgz -C /opt &&\
    rm kafka_${scalaVer}-${kafkaVer}.tgz

RUN apt-get install -qy net-tools telnet iputils-ping vim gettext-base

COPY ./docker-entrypoint_origin.sh /
COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]

#ENV HOST_IDS="1 2 3"
#ENV HOST_IP_PREFIX="172.18.0.20"
#
#RUN for i in $HOST_IDS; \
#    do echo server.$i=$HOST_IP_PREFIX$i:2888:3888 >> /etc/zookeeper/conf/zoo.cfg; \
#    done
#
#RUN export BROKER_LIST="" &&\
#    for i in $HOST_IDS; \
#        do BROKER_LIST="$BROKER_LIST$HOST_IP_PREFIX$i:2181,"; \
#        done &&\
#    BROKER_LIST=$(echo -n $BROKER_LIST | head -c -1) &&\
#    sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$BROKER_LIST/g" /opt/kafka/config/server.properties
