FROM mongo:6.0

VOLUME ["/data/db"]

# Disable SSL and set network configuration
CMD ["mongod", "--noauth", "--bind_ip_all"]