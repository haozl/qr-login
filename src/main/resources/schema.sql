DROP TABLE IF EXISTS users ;
CREATE TABLE users (
  id       INTEGER PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(32) UNIQUE NOT NULL,
  password VARCHAR(64)        NOT NULL,
  enabled  TINYINT            NOT NULL DEFAULT 1,
  token VARCHAR(128) UNIQUE
);

DROP TABLE IF EXISTS user_roles ;
CREATE TABLE user_roles (
  id      INTEGER PRIMARY KEY AUTO_INCREMENT,
  user_id INTEGER     NOT NULL,
  role    VARCHAR(48) NOT NULL,
  UNIQUE KEY role_user( role, user_id)
);



