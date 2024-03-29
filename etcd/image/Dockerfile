FROM ubuntu:22.04
RUN apt-get update

RUN apt-get install -qy ca-certificates openssl tar curl

# https://github.com/etcd-io/etcd/tree/v3.4.22 released on 2022-11-02
ENV ETCD_VER=v3.5.5
ENV DOWNLOAD_URL=https://github.com/etcd-io/etcd/releases/download
ENV ETCD_ROOT=/opt/etcd
ENV PATH=${PATH}:${ETCD_ROOT}

RUN mkdir -p ${ETCD_ROOT}
WORKDIR ${ETCD_ROOT}
RUN curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz \
        -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
RUN tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz \
        -C ${ETCD_ROOT} --strip-components=1
RUN rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
RUN etcd --version

RUN apt-get install -qy net-tools telnet iputils-ping

ENV ETCD_DATA_DIR /etcd-data
ENV ETCD_LISTEN_CLIENT_URLS http://0.0.0.0:2379
ENV ETCD_ADVERTISE_CLIENT_URLS ${ETCD_LISTEN_CLIENT_URLS}
ENV ETCD_LISTEN_PEER_URLS http://127.0.0.1:2380
ENV ETCD_INITIAL_ADVERTISE_PEER_URLS ${ETCD_LISTEN_PEER_URLS}
ENV ETCD_INITIAL_CLUSTER default=http://127.0.0.1:2380
ENV ETCD_INITIAL_CLUSTER_TOKEN etcd-cluster
ENV ETCD_INITIAL_CLUSTER_STATE new
ENV ETCD_LOG_LEVEL info
ENV ETCD_LOGGER zap
ENV ETCD_LOG_OUTPUTS stdout
ENV ETCD_AUTO_COMPACTION_RETENTION=10h
ENV ETCD_AUTO_COMPACTION_MODE=periodic
ENV ETCD_QUOTA_BACKEND_BYTES=8589934592

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash", "-c", "${ETCD_ROOT}/etcd"]
