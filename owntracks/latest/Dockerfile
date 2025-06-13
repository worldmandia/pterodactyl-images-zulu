FROM owntracks/recorder:latest as owntracks

FROM alpine:latest

RUN apk add --no-cache \
    curl \
    ca-certificates \
    openssl \
    git \
    tar \
    sqlite \
    bash \
    dumb-init \
    libcurl \
    libconfig \
    mosquitto-libs \
    lmdb \
    libsodium \
    lua5.3

COPY --from=owntracks /usr/local/bin/ot-recorder /usr/local/bin/
COPY --from=owntracks /usr/local/bin/ocat /usr/local/bin/
COPY --from=owntracks /usr/local/share/ot-recorder/ /usr/local/share/ot-recorder/

RUN adduser -D -h /home/container container

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