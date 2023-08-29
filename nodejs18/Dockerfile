FROM ubuntu:22.04

ENV HOME=/root
WORKDIR $HOME
RUN apt-get update

RUN apt-get install -qy curl git
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh &&\
    bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install -qy nodejs

RUN node --version > $HOME/.nvmrc

ENV NPM_PACKAGES "$HOME/.npm-packages"
RUN mkdir -p $NPM_PACKAGES
RUN npm config set prefix $NPM_PACKAGES
ENV PATH "$PATH:$NPM_PACKAGES/bin"

RUN mkdir -p $HOME/javascript/src/hello
RUN echo 'console.log("hello world NodeJS")' > $HOME/javascript/src/hello/hello.js
RUN node $HOME/javascript/src/hello/hello.js

# optional convenient packages:
RUN apt-get install -qy procps net-tools telnet iputils-ping curl wget vim
