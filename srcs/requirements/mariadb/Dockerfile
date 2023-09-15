# Use the official Debian Bullseye image as the base image
FROM debian:bullseye

# Update package lists and upgrade packages
RUN apt-get update -y && apt-get upgrade -y 

# Install MariaDB server
RUN apt-get install -y mariadb-server mariadb-client

COPY ./conf/db.sql /tmp/db.sql
# Start the MariaDB service and set ownership
# RUN mkdir -P /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql

# Allow MariaDB to bind to all network interfaces (0.0.0.0)
RUN sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i "s/^#port*/port = 3306/g" /etc/mysql/mariadb.conf.d/50-server.cnf

# Change permissions on the mysqld socket directory (consider security implications)
RUN mkdir -p /var/run/mysqld && touch /var/run/mysqld/mysqld.sock \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld/mysqld.sock
# Start the MariaDB service and create the database
# Set the entry point to start the MariaDB server
ENTRYPOINT [ "sleep", "infinity" ]
# CMD ["mysqld -u root -p < /tmp/db.sql"]
