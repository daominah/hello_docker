FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -qy software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get update

ENV BIN_PYTHON=python3.7
RUN apt-get install -qy ${BIN_PYTHON}
RUN apt-get install -qy python3-distutils python3-pip python3-setuptools
RUN apt-get install -qy ${BIN_PYTHON}-dev ${BIN_PYTHON}-venv

RUN ${BIN_PYTHON} -m pip install --index-url https://pypi.python.org/simple/ --upgrade pip
RUN ${BIN_PYTHON} -m pip install virtualenv  # if you want Docker image is similar to dev machine

RUN ${BIN_PYTHON} --version  # Python 3.7.17
RUN ${BIN_PYTHON} -c 'print("hello world")'

RUN apt-get install -qy procps net-tools telnet iputils-ping curl wget vim
