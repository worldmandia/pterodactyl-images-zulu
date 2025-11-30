#!/bin/bash
cd /home/container || exit 1

# Configure colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET_COLOR='\033[0m'

# Print Current Java Version
java -version

# --- NUMA CHECK ---
if command -v numactl >/dev/null 2>&1; then
    NUMA_NODES=$(numactl --hardware | head -n 1 | awk '{print $2}')
    if [ "$NUMA_NODES" -gt 1 ]; then
        echo -e "${GREEN}[NUMA] Detected $NUMA_NODES nodes. Libraries are working.${RESET_COLOR}"
        echo -e "${YELLOW}[TIP] You can add '-XX:+UseNUMA' to your startup flags for performance.${RESET_COLOR}"
    else
        echo -e "${CYAN}[NUMA] Single node or UMA detected. Standard mode.${RESET_COLOR}"
    fi
else
    echo -e "${YELLOW}[NUMA] numactl not found. Did you install libnuma?${RESET_COLOR}"
fi
# ------------------

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Startup Variables
# shellcheck disable=SC2086
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}STARTUP /home/container: ${MODIFIED_STARTUP} ${RESET_COLOR}"

# Run the Server
# shellcheck disable=SC2086
eval exec ${MODIFIED_STARTUP}
