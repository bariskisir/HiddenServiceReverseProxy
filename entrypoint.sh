#!/bin/sh

# Remove the default torrc file, create a new one, and set the hidden service configuration
rm -f /etc/tor/torrc
touch /etc/tor/torrc

echo "HiddenServiceDir ${HIDDEN_SERVICE_DIR}" >> /etc/tor/torrc
echo "HiddenServicePort ${HIDDEN_SERVICE_PORT}" >> /etc/tor/torrc

# Start Tor with the specified configuration
exec tor -f /etc/tor/torrc
