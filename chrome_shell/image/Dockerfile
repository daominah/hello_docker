FROM chromedp/headless-shell:85.0.4183.121

# Debian GNU/Linux 10 (buster)
RUN cat /etc/os-release
RUN sed -i -e 's/deb.debian.org/debian.xtdv.net/g' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update

# install Go
RUN apt-get install -qy git wget
RUN GO_VERSION=go1.14.9.linux-amd64.tar.gz &&\
    cd /opt &&\
    wget --quiet https://dl.google.com/go/$GO_VERSION &&\
    tar -C /usr/local -xzf $GO_VERSION &&\
    rm /opt/$GO_VERSION

RUN mkdir -p /go/src
ENV GOPATH=/go
ENV GOROOT=/usr/local/go
ENV PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

RUN apt-get install -qy graphviz gcc

RUN TMP='package main; func main() {println("Hello world")}' &&\
    mkdir -p /go/src/hello &&\
    echo $TMP> /go/src/hello/hello.go

RUN apt-get install -qy procps net-tools telnet iputils-ping vim gettext-base

# try github.com/chromedp/example
ENV chromeDPDir=${GOPATH}/src/github.com/chromedp
RUN mkdir -p ${chromeDPDir} && cd ${chromeDPDir} &&\
    git clone https://github.com/chromedp/examples &&\
    cd examples && git reset --hard cb21abae103c3e9a5ad08f35e2ec516b6053a17e &&\
    go mod download
