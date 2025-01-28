FROM ubuntu:jammy

LABEL maintainer="carlo.mancini-terracciano@uniroma1.it"
LABEL org.opencontainers.image.source=https://github.com/carlomt/docker-lfc
LABEL org.opencontainers.image.description="Docker container for the Sapienza LFC course"

ENV LANG=C.UTF-8
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -yq install\
    build-essential \
    git \
    ca-certificates \
    clang \
    cmake \ 
    cppcheck \
    curl \    
    dirmngr \
    emacs \
    gpg \
    gnuplot \
    less \
    python3 \
    python3-pip \
    python3-tk \
    wget \
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

# Scarica e compila Google Test
RUN git clone https://github.com/google/googletest.git /googletest && \
    cd /googletest && \
    cmake -S . -B build && \
    cmake --build build && \
    cmake --install build --prefix /usr/local && \
    rm -rf /googletest

RUN echo "backend: TkAgg" >> /usr/local/lib/python3.10/dist-packages/matplotlib/mpl-data/matplotlibr

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/bash", "-c", "exec \"$@\"", "--"]
CMD ["/usr/bin/bash"]
