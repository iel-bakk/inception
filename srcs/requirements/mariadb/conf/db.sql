CREATE DATABASE if not exists my_database;
CREATE USER 'UTRIPPEN'@'%';
GRANT ALL PRIVILEGES ON my_database.* to 'UTRIPPEN'@'%' IDENTIFIED BY '123';
alter user 'root'@'localhost' identified by '123';
FLUSH PRIVILEGES;