FROM ubuntu:22.04
RUN apt-get update

RUN apt-get install -qy curl git
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh &&\
    bash nodesource_setup.sh
RUN apt-get update
RUN apt-get install -qy nodejs

ENV NPM_PACKAGES "$HOME/.npm-packages"
RUN mkdir -p $NPM_PACKAGES
RUN npm config set prefix $NPM_PACKAGES
ENV PATH "$PATH:$NPM_PACKAGES/bin"

RUN TMP='console.log("hello world nodejs")' &&\
    mkdir -p /javascript/src/hello &&\
    echo $TMP> /javascript/src/hello/hello.js &&\
    node /javascript/src/hello/hello.js

RUN apt-get install -qy net-tools telnet iputils-ping vim gettext-base
