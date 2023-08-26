# Use the official Debian base image
FROM debian:bullseye-slim

# Install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server

# Expose the MySQL port
EXPOSE 3306

# Start MariaDB on container startup
CMD ["mysqld"]
