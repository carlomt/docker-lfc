FROM ubuntu:jammy
LABEL maintainer="carlo.mancini-terracciano@uniroma1.it"

WORKDIR /workspace

ENV LANG=C.UTF-8
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -yq install\
    ca-certificates \
    dirmngr \
    gpg \
    wget \
    less \
    build-essential \
    clang \
    emacs \
    gnuplot \
    && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*
    
ENTRYPOINT  ["/usr/bin/bash", "-l"]
