FROM        ubuntu:24.04

LABEL       author="mani1232" maintainer="support@worldmandia.cc"
LABEL       org.opencontainers.image.source="https://github.com/worldmandia/pterodactyl-images-zulu"

ENV         DEBIAN_FRONTEND=noninteractive

USER        root

RUN         apt-get update && apt-get install -y --no-install-recommends \
                curl \
                ca-certificates \
                openssl \
                git \
                tar \
                sqlite3 \
                fontconfig \
                tzdata \
                iproute2 \
                libfreetype6 \
                tini \
                zip \
                unzip \
                osslsigncode \
                libmimalloc2.0 \
                jq \
            && curl -sL https://sentry.io/get-cli/ | bash \
            && sentry-cli update \
            && rm -rf /var/lib/apt/lists/*

ENV         JAVA_URL=https://download.bell-sw.com/java/25.0.2+12/bellsoft-jdk25.0.2+12-linux-amd64-full.tar.gz

ENV         JAVA_HOME=/opt/java/openjdk
ENV         PATH="${JAVA_HOME}/bin:${PATH}"

RUN         mkdir -p /opt/java/openjdk \
            && curl -L ${JAVA_URL} | tar -xz --strip-components=1 -C /opt/java/openjdk

ENV         JMODS_DIR="${JAVA_HOME}/jmods"

RUN         useradd -m -d /home/container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

ENTRYPOINT  ["/usr/bin/tini", "--"]
CMD         [ "/entrypoint.sh" ]