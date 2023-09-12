# FROM debian:bullseye

# RUN apt-get update -y && apt-get upgrade -y 

# RUN apt-get install mariadb-server -y

# RUN service mysql start && chown -R mysql:mysql /var/lib/mysql

# RUN sed -i "s/#port/port/" /etc/mysql/mariadb.conf.d/50-server.cnf

# RUN chmod 777 /var/run/mysqld

# RUN sed -i "s/bind-address ./bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# ENTRYPOINT ["mariadb"]

# Use the official Debian Bullseye image as the base image
FROM debian:bullseye

# Update package lists and upgrade packages
RUN apt-get update -y && apt-get upgrade -y 

# Install MariaDB server
RUN apt-get install -y mariadb-server

# Start the MariaDB service and set ownership
RUN service mariadb start && chown -R mysql:mysql /var/lib/mysql

# Uncomment the 'port' setting in the MariaDB configuration
RUN sed -i "s/#port/port/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Change permissions on the mysqld socket directory (consider security implications)
RUN chmod 777 /var/run/mysqld

# Allow MariaDB to bind to all network interfaces (0.0.0.0)
RUN sed -i "s/bind-address = 127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Expose the default MariaDB port (3306) if needed
EXPOSE 3306

# Set the entry point to start the MariaDB server
ENTRYPOINT ["mysqld"]