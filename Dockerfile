# Use the latest Alpine image as the base
FROM alpine:latest

# Install Tor without updating the package index
RUN apk add --no-cache tor

# Set the appropriate permissions for Tor configuration
RUN chown -R tor /etc/tor

# Copy the entrypoint script into the root of the container
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Switch to the 'tor' user
USER tor

# Set the entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]
