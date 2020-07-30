FROM zookeeper:3.5.7
# Debian GNU/Linux 10 (buster)

# change to Vietnam mirror, main mirror is so slow
RUN sed -i -e 's/deb.debian.org/debian.xtdv.net/g' /etc/apt/sources.list
RUN apt-get update

# kafka:2.5.0, released 2020-04-15, prefer Zookeeper to 3.5.7
ENV kafkaVer 2.5.0
ENV scalaVer 2.12
ENV kafkaMirror http://mirrors.viethosting.com/apache/kafka
RUN wget -q ${kafkaMirror}/${kafkaVer}/kafka_${scalaVer}-${kafkaVer}.tgz
RUN tar -xzf kafka_${scalaVer}-${kafkaVer}.tgz -C /opt &&\
    rm kafka_${scalaVer}-${kafkaVer}.tgz
RUN mv /opt/kafka_${scalaVer}-${kafkaVer} /opt/kafka

RUN apt-get install -qy gettext-base
RUN apt-get install -qy net-tools telnet iputils-ping vim procps

RUN apt-get install -qy supervisor

COPY supervisor/zookeeper.conf /etc/supervisor/conf.d/
COPY supervisor/kafka.conf /etc/supervisor/conf.d/
COPY kafka_server.properties.tpl /
COPY docker_start_kafka.sh /
COPY docker-entrypoint_zoo.sh /
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["supervisord", "--nodaemon"]
