FROM ubuntu:18.04
RUN apt-get update


# install nodejs
RUN apt-get install -qy curl git
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh &&\
    bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install -qy nodejs

ENV NPM_PACKAGES "/root/.npm-packages"
RUN mkdir -p $NPM_PACKAGES
RUN npm config set prefix $NPM_PACKAGES
ENV PATH "$PATH:$NPM_PACKAGES/bin"

RUN TMP='console.log("hello")' &&\
    mkdir -p /javascript/src/hello &&\
    echo $TMP> /javascript/src/hello/hello.js

# optional packages: vim 54Mb, net 2Mb
RUN apt-get install -qy vim
RUN apt-get install -qy net-tools telnet
