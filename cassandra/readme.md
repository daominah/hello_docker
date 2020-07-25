# Cassandra cluster

## Single instance

* Run server:  
  ````bash
  docker run -dit \
      -p 7000:7000 -p 7001:7001 -p 9042:9042 -p 7199:7199 \
      --name cassandra \
      cassandra:3.11.6
  ````  
  By default, Cassandra uses 9042 for native protocol clients, 7000 for
  cluster communication (7001 if SSL is enabled), and 7199 for JMX.
* Run shell client
  `docker run -it --network host --rm cassandra:3.11.6 cqlsh`  
  (rm flag: the container will be autoremoved when it stopped)

## Cluster

TODO
