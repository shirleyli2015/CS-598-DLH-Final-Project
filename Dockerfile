FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y python3.8 python3-pip cython

COPY related_code/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

ENTRYPOINT ["/bin/bash"]
