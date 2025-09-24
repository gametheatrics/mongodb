FROM mongo:6.0

# Copy MongoDB configuration file
COPY mongod.conf /etc/mongod.conf

# Create log directory
RUN mkdir -p /var/log/mongodb

VOLUME ["/data/db"]

# Use configuration file to disable SSL explicitly
CMD ["mongod", "--config", "/etc/mongod.conf"]