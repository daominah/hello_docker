FROM mysql:8.0.20

RUN apt-get update
RUN apt-get install -qy net-tools telnet iputils-ping
RUN apt-get install -qy vim

COPY "./step2_group_on_boot.sh" "/step2_group_on_boot.sh"
EXPOSE 3306 33060 33061
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
