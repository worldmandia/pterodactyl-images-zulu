FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    openssl \
    git \
    tar \
    sqlite3 \
    bash \
    dumb-init \
    build-essential \
    libcurl4-openssl-dev \
    libconfig-dev \
    libmosquitto-dev \
    liblmdb-dev \
    libsodium-dev \
    liblua5.3-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone https://github.com/owntracks/recorder.git && \
    cd recorder && \
    cp config.mk.in config.mk && \
    make && \
    make install

RUN apt-get update && apt-get remove -y \
    build-essential \
    libcurl4-openssl-dev \
    libconfig-dev \
    libmosquitto-dev \
    liblmdb-dev \
    libsodium-dev \
    liblua5.3-dev \
    pkg-config \
    && apt-get autoremove -y \
    && apt-get install -y \
    libcurl4 \
    libconfig9 \
    libmosquitto1 \
    liblmdb0 \
    libsodium23 \
    liblua5.3-0 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/container -m container

RUN mkdir -p /home/container/data /home/container/config

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R container:container /home/container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

STOPSIGNAL SIGINT

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]