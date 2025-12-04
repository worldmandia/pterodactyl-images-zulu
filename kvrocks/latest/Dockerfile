# ----------------------------------
# Environment: redis
# ----------------------------------
FROM    --platform=$TARGETOS/$TARGETARCH apache/kvrocks:nightly

ENV     DEBIAN_FRONTEND=noninteractive

RUN     apt-get update \
        && apt-get -y install --no-install-recommends iproute2 \
        && useradd -m -d /home/container container \

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ../entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
