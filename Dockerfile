FROM alpine:latest
RUN apk update && apk add tor
RUN chown -R tor /etc/tor
USER tor
CMD ["sh","-c","rm -f /etc/tor/torrc && touch /etc/tor/torrc && echo 'HiddenServiceDir '$HIDDEN_SERVICE_DIR >> /etc/tor/torrc && echo 'HiddenServicePort '$HIDDEN_SERVICE_PORT >> /etc/tor/torrc && tor -f /etc/tor/torrc"]
