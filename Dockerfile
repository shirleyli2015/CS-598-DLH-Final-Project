FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y python3.8 python3-pip cython

RUN pip3 install h5py matplotlib numpy pandas pickle5 sklearn tqdm torch torchdiffeq

ENTRYPOINT ["/bin/bash"]
