CREATE DATABASE dashboard CHARACTER SET utf8;
CREATE USER 'dashboard'@'localhost' IDENTIFIED BY 'puppet';
GRANT ALL PRIVILEGES ON dashboard.* TO 'dashboard'@'localhost';
