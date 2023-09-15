CREATE DATABASE if not exists inception_db;
CREATE USER 'iel-bakk'@'%';
GRANT ALL PRIVILEGES ON inception_db.* to 'iel-bakk'@'%' IDENTIFIED BY 'iel-bakk';
alter user 'root'@'localhost' identified by '123';
FLUSH PRIVILEGES;