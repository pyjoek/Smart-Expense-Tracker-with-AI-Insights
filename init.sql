CREATE DATABASE IF NOT EXISTS expense_tracker;

CREATE USER IF NOT EXISTS 'trackuser'@'%' 
  IDENTIFIED WITH caching_sha2_password BY 'trackpass';

GRANT ALL PRIVILEGES ON expense_tracker.* TO 'trackuser'@'%';

FLUSH PRIVILEGES;
