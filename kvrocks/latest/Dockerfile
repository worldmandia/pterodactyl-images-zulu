# ----------------------------------
# Environment: redis
# ----------------------------------
FROM    --platform=$TARGETOS/$TARGETARCH apache/kvrocks:nightly

ENV     DEBIAN_FRONTEND=noninteractive

RUN     apt-get update \
        && apt-get -y install --no-install-recommends iproute2 \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && useradd -m -d /home/container container \
        && locale-gen en_US.UTF-8

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ../entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
