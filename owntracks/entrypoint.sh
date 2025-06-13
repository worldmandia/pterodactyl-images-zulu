#!/bin/bash
cd /home/container

function apply_path {
    if [ -f "$1" ]; then

        sed -i "s|\${SERVER_JARFILE}|${SERVER_JARFILE}|g" "$1"
        sed -i "s|\${STARTUP}|${STARTUP}|g" "$1"

        sed -i "s|\${OTR_HOST}|${OTR_HOST:-0.0.0.0}|g" "$1"
        sed -i "s|\${OTR_PORT}|${OTR_PORT:-8083}|g" "$1"
        sed -i "s|\${OTR_STORAGEDIR}|${OTR_STORAGEDIR:-/home/container/data}|g" "$1"
        sed -i "s|\${OTR_TOPICS}|${OTR_TOPICS:-owntracks/+/+}|g" "$1"
        sed -i "s|\${OTR_BROWSERAPIKEY}|${OTR_BROWSERAPIKEY}|g" "$1"
        sed -i "s|\${OTR_HTTPHOST}|${OTR_HTTPHOST:-0.0.0.0}|g" "$1"
        sed -i "s|\${OTR_HTTPPORT}|${OTR_HTTPPORT:-8083}|g" "$1"
        sed -i "s|\${OTR_HTTPLOGDIR}|${OTR_HTTPLOGDIR:-/home/container/data}|g" "$1"
        sed -i "s|\${MQTT_HOST}|${MQTT_HOST:-localhost}|g" "$1"
        sed -i "s|\${MQTT_PORT}|${MQTT_PORT:-1883}|g" "$1"
        sed -i "s|\${MQTT_USER}|${MQTT_USER}|g" "$1"
        sed -i "s|\${MQTT_PASS}|${MQTT_PASS}|g" "$1"
    fi
}

for file in *.conf *.config *.yml *.yaml *.json *.txt; do
    if [ -f "$file" ]; then
        apply_path "$file"
    fi
done

if [ ! -f "ot-recorder.conf" ]; then
    cat > ot-recorder.conf << EOF
OTR_HOST = "${OTR_HOST:-0.0.0.0}"
OTR_PORT = ${OTR_PORT:-8083}
OTR_STORAGEDIR = "${OTR_STORAGEDIR:-/home/container/data}"
OTR_TOPICS = "${OTR_TOPICS:-owntracks/+/+}"
OTR_HTTPHOST = "${OTR_HTTPHOST:-0.0.0.0}"
OTR_HTTPPORT = ${OTR_HTTPPORT:-8083}
OTR_HTTPLOGDIR = "${OTR_HTTPLOGDIR:-/home/container/data}"

# MQTT Configuration
MQTT_HOST = "${MQTT_HOST:-localhost}"
MQTT_PORT = ${MQTT_PORT:-1883}
EOF

    if [ -n "$MQTT_USER" ]; then
        echo "MQTT_USER = \"$MQTT_USER\"" >> ot-recorder.conf
    fi

    if [ -n "$MQTT_PASS" ]; then
        echo "MQTT_PASS = \"$MQTT_PASS\"" >> ot-recorder.conf
    fi

    if [ -n "$OTR_BROWSERAPIKEY" ]; then
        echo "OTR_BROWSERAPIKEY = \"$OTR_BROWSERAPIKEY\"" >> ot-recorder.conf
    fi
fi

mkdir -p "${OTR_STORAGEDIR:-/home/container/data}"
mkdir -p "${OTR_HTTPLOGDIR:-/home/container/data}"

echo "Starting OwnTracks Recorder..."
echo "Config file: ot-recorder.conf"
echo "Storage directory: ${OTR_STORAGEDIR:-/home/container/data}"
echo "HTTP host: ${OTR_HTTPHOST:-0.0.0.0}"
echo "HTTP port: ${OTR_HTTPPORT:-8083}"
echo "MQTT host: ${MQTT_HOST:-localhost}"
echo "MQTT port: ${MQTT_PORT:-1883}"

if [ -n "$STARTUP" ]; then
    echo "Executing startup command: $STARTUP"
    exec ${STARTUP}
else
    echo "Starting ot-recorder with default configuration..."
    exec ot-recorder --config ot-recorder.conf
fi