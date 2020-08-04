FROM mysql:8.0.20

# change to Vietnam mirror
RUN sed -i -e 's/deb.debian.org/debian.xtdv.net/g' /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -qy net-tools telnet iputils-ping vim gettext-base

COPY ./config-file.cnf_tpl /
COPY ./my_entrypoint.sh /

ENTRYPOINT ["bash", "/my_entrypoint.sh"]
CMD ["mysqld"]
