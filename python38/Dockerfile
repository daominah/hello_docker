FROM ubuntu:18.04

RUN apt update
RUN apt install -qy python3.8
RUN apt install -qy python3-distutils python3-pip python3-setuptools
RUN apt install -qy python3.8-dev python3.8-venv

RUN python3.8 -m pip install --index-url https://pypi.python.org/simple/ --upgrade pip
RUN python3.8 -m pip install virtualenv

RUN apt install --quiet --yes net-tools telnet wget git vim
