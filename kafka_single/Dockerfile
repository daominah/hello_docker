FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install --quiet --yes net-tools wget tree htop vim telnet

# install zookeeper
RUN apt-get install -yq default-jre zookeeper
RUN mkdir -p /home/tungdt/var/zookeeper

# install kafka
RUN mkdir -p /home/tungdt/opt
RUN cd /home/tungdt/opt &&\
    wget -q http://mirrors.viethosting.com/apache/kafka/2.3.0/kafka_2.12-2.3.0.tgz
RUN tar -xzf /home/tungdt/opt/kafka_2.12-2.3.0.tgz -C /home/tungdt/opt

# default zookeeper, kafka config
COPY ./zoo.cfg /etc/zookeeper/conf
COPY ./myid /home/tungdt/var/zookeeper
COPY ./server.properties /home/tungdt/opt/kafka_2.12-2.3.0/config

WORKDIR /home/tungdt/opt/kafka_2.12-2.3.0/bin

CMD /usr/share/zookeeper/bin/zkServer.sh start &&\
    /usr/share/zookeeper/bin/zkServer.sh status &&\
    ./kafka-server-start.sh ../config/server.properties
