FROM ubuntu:18.04

RUN apt update

ENV BIN_PYTHON python3.8
RUN apt install -qy ${BIN_PYTHON}
RUN apt install -qy python3-distutils python3-pip python3-setuptools
RUN apt install -qy ${BIN_PYTHON}-dev ${BIN_PYTHON}-venv

RUN ${BIN_PYTHON} -m pip install --index-url https://pypi.python.org/simple/ --upgrade pip
RUN ${BIN_PYTHON} -m pip install virtualenv

RUN apt install --quiet --yes net-tools telnet wget git vim

RUN ${BIN_PYTHON} --version
RUN ${BIN_PYTHON} -c 'print("hello world")'
