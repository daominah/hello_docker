CREATE DATABASE concurrent CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE `shareds` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `val` int DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO shareds VALUES ("key0", 10);
