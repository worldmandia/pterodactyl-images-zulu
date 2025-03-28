FROM        mongo:8-noble

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

ENV         DEBIAN_FRONTEND=noninteractive

RUN         apt-get update \
            && apt-get -y install netcat iproute2 \
            && apt-get clean \
            && useradd -d /home/container -m container -s /bin/bash

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]