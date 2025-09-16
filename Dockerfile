FROM mongo:6.0

# Enable authentication (optional - only if you want username/password)
CMD ["mongod", "--auth"]

VOLUME ["/data/db"]