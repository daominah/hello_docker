FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -yq software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install -yq python3.7

COPY ./main.py /main.py
CMD python3.7 /main.py