# ----------------------------------
# Environment: redis
# ----------------------------------
FROM    --platform=$TARGETOS/$TARGETARCH apache/kvrocks:nightly

ENV     DEBIAN_FRONTEND=noninteractive

RUN     sudo apt-get update \
        && sudo apt-get -y install --no-install-recommends iproute2 \
        && sudo apt-get clean \
        && sudo rm -rf /var/lib/apt/lists/* \
        && sudo useradd -m -d /home/container container \
        && sudo locale-gen en_US.UTF-8

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ../entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
