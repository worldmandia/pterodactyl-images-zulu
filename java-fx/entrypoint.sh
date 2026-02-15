#!/bin/bash

TZ=${TZ:-UTC}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

MIMALLOC_LIB=$(find /usr/lib -name "libmimalloc.so*" | head -n 1)
if [ -n "$MIMALLOC_LIB" ]; then
    export LD_PRELOAD="$MIMALLOC_LIB"
    export MIMALLOC_LARGE_OS_PAGES=1
    printf "\033[1m\033[32m[OPTIMIZATION]\033[0m Mimalloc loaded: %s\n" "$MIMALLOC_LIB"
fi

cd /home/container || exit 1

printf "\033[1m\033[33mcontainer@gravitlauncher~ \033[0mJava Environment:\n"
echo "JAVA_HOME: $JAVA_HOME"
java -version

if [ -d "$JMODS_DIR" ]; then
    printf "\033[1m\033[33mcontainer@gravitlauncher~ \033[0mJMODS (JavaFX) found at: %s\n" "$JMODS_DIR"
else
    printf "\033[1m\033[31m[WARNING]\033[0m JMODS dir not found! LaunchServer compilation might fail if JavaFX is missing.\n"
fi

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

printf "\033[1m\033[33mcontainer@gravitlauncher~ \033[0m%s\n" "$PARSED"

eval ${PARSED}