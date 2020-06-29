FROM mysql:8.0.20

RUN apt-get update
RUN apt-get install -qy net-tools telnet

COPY "./docker-entrypoint.sh" "/docker-entrypoint.sh"
COPY "./docker-entrypoint.sh" "/entrypoint.sh"
RUN chmod 777 "/docker-entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3306 33060 33061

CMD ["mysqld"]
