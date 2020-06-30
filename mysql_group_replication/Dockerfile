FROM mysql:8.0.20

RUN apt-get update
RUN apt-get install -qy net-tools telnet iputils-ping

EXPOSE 3306 33060 33061
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
