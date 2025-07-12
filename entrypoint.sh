#!/bin/sh

# Set the HiddenServiceDir to a fixed location
HIDDEN_SERVICE_DIR="/var/lib/tor/hidden_service"

# Default application port (can be overridden)
APP_PORT=${APP_PORT:-80}

# Ensure that we have an APP_IP_DOMAIN
if [ -z "$APP_IP_DOMAIN" ]; then
  echo "Error: APP_IP_DOMAIN is not set. Please set the APP_IP_DOMAIN environment variable."
  exit 1
fi

# Configure Tor with the hidden service
echo "HiddenServiceDir ${HIDDEN_SERVICE_DIR}" > /etc/tor/torrc
echo "HiddenServicePort ${APP_PORT} ${APP_IP_DOMAIN}:${APP_PORT}" >> /etc/tor/torrc

# Start Tor in the background
tor -f /etc/tor/torrc &

# Poll for the .onion address (hostname) with a timeout
TIMEOUT=3600
INTERVAL=5
ELAPSED_TIME=0

while [ ! -f "${HIDDEN_SERVICE_DIR}/hostname" ] && [ $ELAPSED_TIME -lt $TIMEOUT ]; do
  echo "Waiting for Tor to initialize and generate the .onion address... (Elapsed: $ELAPSED_TIME seconds)"
  sleep $INTERVAL
  ELAPSED_TIME=$((ELAPSED_TIME + INTERVAL))
done

# If the hostname file exists, print the .onion address
if [ -f "${HIDDEN_SERVICE_DIR}/hostname" ]; then
  ONION_ADDRESS=$(cat ${HIDDEN_SERVICE_DIR}/hostname)
  echo "Your onion address is: ${ONION_ADDRESS}"
else
  echo "Tor did not generate the .onion address within the expected time of ${TIMEOUT} seconds."
fi

# Keep the container running (optional)
tail -f /dev/null
