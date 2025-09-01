CREATE DATABASE IF NOT EXISTS trackdb;

CREATE USER IF NOT EXISTS 'trackuser'@'%' 
  IDENTIFIED WITH caching_sha2_password BY 'trackpass';

GRANT ALL PRIVILEGES ON trackdb.* TO 'trackuser'@'%';

FLUSH PRIVILEGES;
