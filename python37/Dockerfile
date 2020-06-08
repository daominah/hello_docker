FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -qy python3.7
RUN apt-get install -qy python3-dev python3-distutils python3-pip \
   python3-setuptools python3.7-venv

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

RUN python3 -m pip install --index-url https://pypi.python.org/simple/ --upgrade pip
RUN python3 -m pip install virtualenv

RUN apt-get install --quiet --yes net-tools telnet wget git vim
