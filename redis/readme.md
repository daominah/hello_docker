# Redis

Key value store server.

## Single instance

* Run server:
  
  ````bash
  docker run -dit -p 6379:6379 --name redis6 redis:6.0.6-buster
  ````  
  
* Run shell client
  ````bash
  docker run -it --network host --rm redis:6.0.6-buster \
      redis-cli -h 127.0.0.1
  ```` 
  
## Cluster

TODO
