FROM owntracks/recorder:latest

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    openssl \
    git \
    tar \
    sqlite3 \
    bash \
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