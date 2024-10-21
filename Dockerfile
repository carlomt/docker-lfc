FROM ubuntu:jammy

LABEL maintainer="carlo.mancini-terracciano@uniroma1.it"
LABEL org.opencontainers.image.source=https://github.com/carlomt/docker-lfc
LABEL org.opencontainers.image.description="Docker container for the Sapienza LFC course"

WORKDIR /workspace

ENV LANG=C.UTF-8
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
ENV DEBIAN_FRONTEND=noninteractive

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -yq install\
    ca-certificates \
    cppcheck \
    curl \    
    dirmngr \
    gpg \
    wget \
    less \
    build-essential \
    clang \
    emacs \
    gnuplot \
    python3 \
    python3-pip \
    python3-tk \    
    && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install \
    numpy \
    scipy \
    matplotlib \
    ipython \
    ;

RUN echo "backend: TkAgg" >> /usr/local/lib/python3.10/dist-packages/matplotlib/mpl-data/matplotlibr

ENTRYPOINT ["/usr/bin/bash", "-c", "exec \"$@\"", "--"]
CMD ["/usr/bin/bash"]