CREATE DATABASE daominah CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE `shareds` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `val` int(11) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO shareds VALUES ("key0", 10);
