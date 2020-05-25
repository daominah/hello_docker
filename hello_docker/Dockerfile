# The base OS
FROM ubuntu:14.04

MAINTAINER TungDT <tung.daothanhtung@gmail.com>

# Set the working directory to /app
WORKDIR /home/tungdt/go/src/github.com/daominah

RUN apt update
RUN apt install --quiet --yes wget

# install golang
RUN cd /opt && \
    wget --quiet https://dl.google.com/go/go1.12.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.12.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /home/tungdt/go
ENV GO111MODULE on

# get the project
RUN apt install --quiet --yes git
RUN git clone https://github.com/daominah/hello_go && \
    cd hello_go && \
    git checkout c4713b1cf8d96ab9c967cdd7cfa69ed2f3764da3 && \
    cd http_server && \
    go build

# Make port 80 available to the world outside this container
EXPOSE 8080

# docker run -p 8080:8080 minah_ubuntu14_go11
CMD ./hello_go/http_server/http_server

