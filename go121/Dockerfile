# This image keeps GOROOT content and install many convenient debugging packages
# so the image is heavy (about 500 MB). For a lean image, use the following
# guide instead: https://docs.docker.com/language/golang/build-images/

FROM ubuntu:22.04

ENV HOME=/root
WORKDIR $HOME
RUN apt-get update

RUN apt-get install -qy wget
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

RUN mkdir -p $GOROOT
ARG GOVERSION=go1.21.0
ENV GO_BINARY_DISTRIBUTION=$GOVERSION.linux-amd64.tar.gz
RUN wget --quiet https://dl.google.com/go/$GO_BINARY_DISTRIBUTION
RUN tar -C $GOROOT -xzf $GO_BINARY_DISTRIBUTION --strip-components 1
RUN rm $GO_BINARY_DISTRIBUTION
RUN go version

RUN mkdir -p $GOPATH/src/hello
RUN echo 'package main; func main() {println("hello world Go")}' > $GOPATH/src/hello/hello.go
RUN go run $GOPATH/src/hello/hello.go

# the following lines are optional convenient packages:
RUN apt-get install -qy procps net-tools telnet iputils-ping curl wget vim  # for checking network 65MB
#RUN apt-get install -qy graphviz  # for easy profiling Go code in the container 74 MB
#RUN apt-get install -qy gcc  # if the project needs cgo, not recommended 158 MB

CMD ["bash"]
