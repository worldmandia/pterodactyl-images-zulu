FROM alpine:3.21.3 AS builder

# ARG RECORDER_VERSION=0.9.9
ARG RECORDER_VERSION=master

ENV DOCKER_RUNNING=1

RUN apk add --no-cache \
        make \
        gcc \
        git \
        shadow \
        musl-dev \
        curl-dev \
        libconfig-dev \
        mosquitto-dev \
        lmdb-dev \
        libsodium-dev \
        lua5.2-dev \
	util-linux-dev

RUN git clone --branch=${RECORDER_VERSION} https://github.com/owntracks/recorder /home/container
WORKDIR     /home/container

COPY config.mk .
RUN make -j $(nprocs)
RUN make install DESTDIR=/app

FROM alpine:3.21.3

ENV DOCKER_RUNNING=1

VOLUME ["/store", "/config"]

RUN apk add --no-cache \
	curl \
	jq \
	libcurl \
	libconfig \
	mosquitto \
	lmdb \
	libsodium \
	lua5.2 \
	util-linux \
	tzdata

ENV TZ="UTC"

COPY ./recorder.conf /config/recorder.conf
COPY ./JSON.lua /config/JSON.lua

COPY --from=builder /app /

COPY ./recorder-health.sh /recorder-health.sh
COPY ./entrypoint.sh /entrypoint.sh

ENV OTR_STORAGEDIR=/store
ENV OTR_TOPIC="owntracks/#"

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/entrypoint.sh" ]